package com.gitbaby.happygivers.service;


import java.util.ArrayList;
import java.util.List;


import com.gitbaby.happygivers.domain.*;

import com.gitbaby.happygivers.mapper.*;
import lombok.AllArgsConstructor;


import com.gitbaby.happygivers.domain.dto.Criteria;
import com.gitbaby.happygivers.domain.en.Status;
import lombok.extern.slf4j.Slf4j;

import com.gitbaby.happygivers.util.S3Util;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Slf4j
@Service
@AllArgsConstructor
public class BoardService {
  private MemberMapper memberMapper;
  private BoardMapper boardMapper;
  private AttachMapper attachMapper;
  private DonateMapper donateMapper;
  private ReplyMapper replyMapper;
  private LikeMapper likeMapper;
  private CategoryMapper categoryMapper;
	private DonateService donateService;

  // 게시글 생성
  @Transactional
  public void write(Board board) {
    boardMapper.insert(board);
    if (board.getAttach() != null) {
      Attach attach = board.getAttach();
      attach.setBno(board.getBno());
      attachMapper.insert(attach);
    }
    if (board.getImages() != null) {
      for (Attach i : board.getImages()) {
        i.setViewbno(board.getBno());
        attachMapper.insert(i);
      }
    }
  }

  // 기부 게시글
  @Transactional
  public void write(Board board, Donate donate, DonateRound round) {

    if (donate.getDno() == null) {
      // 1. 모금함 생성 - 첫회차일때
      donateMapper.insert(donate);
    } else { // 첫회차가 아닐 때
      round.setRound(donateMapper.findByMaxRound(donate.getDno()) + 1);
    }

    // 2-1. 모금함 번호를 회차에 넣고, 회차 생성
    round.setDno(donate.getDno());
    donateMapper.insertRound(round);

    // 3. 생성된 회차번호를 게시글에 넣고 게시글 생성
    board.setDrno(round.getDrno());
    boardMapper.insert(board);

    // 4. 첨부파일에 bno 넣고 첨부파일 생성
    if (board.getAttach() != null) {
      Attach attach = board.getAttach();
      attach.setBno(board.getBno());
      attachMapper.insert(attach);
    }

    // 게시글 내부 이미지에 bno 붙여주기
    if (board.getImages() != null) {
      for (Attach i : board.getImages()) {
        i.setViewbno(board.getBno());
        i.setImage(true);
        attachMapper.insert(i);
      }
    }
  }


  // 수정하는데 기부회차 정보가 있으면, 회차정보도 상태 동일하게 수정, 썸네일도 수정
  @Transactional
  public void modify(Board board) {
    if (board.getDrno() != null) {
      DonateRound round = findRound(board.getDrno());
      round.setStatus(board.getStatus());
      donateMapper.updateRound(round);
    }

    if (board.getAttach() != null) {
      if (attachMapper.selectOne(board.getBno()) != null) {
        String removeImg = attachMapper.selectOne(board.getBno()).getS3Key();
        S3Util.remove(removeImg);
        attachMapper.update(board.getAttach());
      } else {
        Attach img = board.getAttach();
        img.setBno(board.getBno());
        attachMapper.insert(img);
      }
    }

    if (board.getImages() != null) {
      List<Attach> modifyImgs = modifyViewImgList(board.getImages(), attachMapper.findByViewBno(board.getBno()));
      log.info("{}", modifyImgs);
      for (Attach i : modifyImgs) {
        i.setViewbno(board.getBno());
        attachMapper.insert(i);
      }
    }

    boardMapper.update(board);
  }


  // 게시글, 회차정보 Status값 delete로 변경
  @Transactional
  public void remove(Long bno) {
    Board board = findByBno(bno);

		if (board.getDrno() != null) {
      DonateRound round = donateMapper.selectOneRound(board.getDrno());
      round.setStatus(Status.DELETE);
      donateMapper.updateRound(round);
    }
    List<Attach> viewImgs = new ArrayList<>();

    if (findAttach(bno) != null) {
      viewImgs.add(findAttach(bno));
    }
    if (attachMapper.findByViewBno(bno) != null) {
      viewImgs.addAll(attachMapper.findByViewBno(bno));
    }

    if (!viewImgs.isEmpty()) {
      List<String> keys = viewImgs.stream()
        .map(Attach::getS3Key)
        .toList();

      S3Util.removeAll(keys);
      attachMapper.deleteByBno(bno);
    }

    // 댓글 삭제
    if (replyMapper.selectByBno(bno) != null) {
      List<Reply> replys = replyMapper.selectByBno(bno);
      ReplyService replyService = new ReplyService();
      for (Reply r : replys) {
        replyService.remove(r.getRno());
      }
    }

    // 좋아요 삭제
    if (likeMapper.findByBno(bno) != null) {
      likeMapper.deleteByRno(bno);
    }

    board.setStatus(Status.DELETE);
    boardMapper.update(board);
  }

  // 전체 리스트
  public List<Board> list(Criteria cri) {
    List<Board> list = boardMapper.list(cri);

    for (Board b : list) {
      b.setCtype(categoryMapper.selectOne(b.getCno()).getCtype());
      b.setCname(findCname(b.getCno()));
      b.setNickname(findNickname(b.getMno()));
      b.setName(findName(b.getMno()));
      b.setThumbnail(findThumbnail(b.getBno()));
      b.setAttach(findAttach(b.getBno()));
      if (b.getDrno() != null) {
        b.setRound(findRound(b.getDrno()));
      }
    }

    return list;
  }


  // 게시글 개수 가져오기
  public long getCount(Criteria cri) {
    return boardMapper.getCount(cri);
  }


  // bno로 게시글 가져오기
  public Board findByBno(Long bno) {
    Board board = boardMapper.selectOne(bno);
    board.setThumbnail(findThumbnail(bno));
    board.setAttach(findAttach(bno));
    board.setNickname(findNickname(board.getMno()));
    board.setName(findName(board.getMno()));

    if (board.getDrno() != null) {
      board.setRound(findRound(board.getDrno()));
    }

    return board;
  }


  // 썸네일 가져오기
  public String findThumbnail(Long bno) {
    if (bno == null) return null;
    return  attachMapper.getBoardThumbnail(bno);
  }

  // 첨부파일 가져오기
  public Attach findAttach(Long bno) {
    if (bno == null) return null;

    Attach attach = null;
    if (attachMapper.selectOne(bno) != null) {
      attach = attachMapper.selectOne(bno);
    }

    return attach;
  }


  // 회차정보 가져오기
  public DonateRound findRound(Long drno) {
    if (drno == null) return null;

    DonateRound round = donateMapper.selectOneRound(drno);

    List<Member> members = donateService.findTop3(drno);
    round.setTop3(members);

    return round;
  }

  // 카테고리명 가져오기
  public String findCname(Integer cno) {
    if (cno == null) return null;

    Category cate = categoryMapper.selectOne(cno);
    return cate.getCname();
  }

  // 작성자명 가져오기
  public String findName(Long mno) {
    if (mno == null) return null;

    Member member = memberMapper.findByMno(mno);

    return member.getName();
  }

  // 닉네임 가져오기
  public String findNickname(Long mno) {
    if (mno == null) return null;

    Member member = memberMapper.findByMno(mno);
    if (member.getNickname() == null) {
      return null;
    }
    return member.getNickname();
  }


  // 댓글 개수 가져오기
  public int getReplyCount(Long bno) {
    return replyMapper.getReplyCount(bno);
  }

  // 마감임박 게시글 가져오기
  public Board findByDeadline() {
    Board board = boardMapper.selectOneDeadline();
    board.setRound(findRound(board.getDrno()));
    board.setThumbnail(findThumbnail(board.getBno()));
    board.setName(findName(board.getMno()));

    return board;
  }

  // 마감임박 게시글 가져오기
  public List<Board> findNewList() {
    List<Board> newBoards = boardMapper.listNew();
    for (Board b : newBoards) {
      b.setRound(findRound(b.getDrno()));
      b.setName(findName(b.getMno()));
      b.setThumbnail(findThumbnail(b.getBno()));
    }
    return newBoards;
  }

  // 이미지 제거한 컨텐츠 가져오기
  public String removeImgContent(String content) {
    if (content == null) return "";
    return content.replaceAll("!\\[.*?\\]\\(.*?\\)", "");
  }


  // 원본 게시글과 수정 게시글 비교하여 변경사항 삭제, 기존에 있던것은 리스트 유지
  public List<Attach> modifyViewImgList(List<Attach> newList, List<Attach> originList) {
    List<Attach> modifyImgList = new ArrayList<Attach>();
    List<Attach> uselist = new ArrayList<>();

    for (Attach i : newList) {
      if (!originList.contains(i)) {
        modifyImgList.add(i);
      } else {
        uselist.add(i);
      }
    }

    originList.removeAll(uselist);

    for (Attach a : originList) {
      S3Util.remove(a.getS3Key());
      attachMapper.delete(a.getUuid());
    }
    log.info("{}", modifyImgList);

    return modifyImgList;
  }

  // 메인 - 공지사항 세개 불러오기
  public List<Board> findNoticeList() {
    return boardMapper.listNotice();
  }

  // 메인 - Q&A 세개 불러오기
  public List<Board> findQnaList() {
    return  boardMapper.listQna();
  }

  // mno로 게시글 세개 가져오기
  public List<Board> findMnoDonateList(Long mno) {
    List<Board> myDonates = boardMapper.listByMnoDonate(mno);

    for (Board b : myDonates) {
      b.setThumbnail(findThumbnail(b.getBno()));
      b.setName(findName(b.getMno()));
    }

    return myDonates;
  }


  // 총 게시글 수(활성화 상태)
  public int totalBoardCount() {
    return boardMapper.totalBoardCount();
  }

  // 마감된 게시글 수
  public int totalVoidCount() {
    return boardMapper.totalVoidCount();
  }

  // 오늘 생성된 게시글 수
  public int todayBoardCount() {
    return boardMapper.todayBoardCount();
  }

  // 자신이 쓴 게시글 보기(삭제된 게시글 제외)
  public List<Board> myBoardList(Long mno) {
    List<Board> boards = boardMapper.myBoardList(mno);

    for (Board b : boards) {
      b.setCtype(categoryMapper.selectOne(b.getCno()).getCtype());
      if (b.getDrno() != null) {
        b.setRound(findRound(b.getDrno()));
      }
    }

    return boards;
  }

  // 사용자 좋아요 여부
  public boolean checkBoardLiked(Long bno, Long mno) {
    if (mno == null) {
      return false;
    }
    return likeMapper.checkBoardLiked(bno, mno);
  }


  // status값만 Active로 변경
  @Transactional
  public void changeStatusActive(Long bno) {
    Board board = findByBno(bno);
    DonateRound round = findRound(board.getDrno());
    round.setStatus(Status.ACTIVE);
    donateMapper.updateRound(round);

    board.setStatus(Status.ACTIVE);
    boardMapper.update(board);
  }
}

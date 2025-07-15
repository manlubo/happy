package com.gitbaby.happygivers.mapper;



import com.gitbaby.happygivers.domain.Category;


public interface CategoryMapper {
	void insert(Category cate);
	void delete(Integer cno);
	void update(Category cate);
	
	Category selectOne(Integer cno);
}

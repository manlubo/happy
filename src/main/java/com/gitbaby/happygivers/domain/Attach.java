package com.gitbaby.happygivers.domain;

import java.util.Objects;

import org.apache.ibatis.type.Alias;

//import controller.attach.UploadFile;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Alias("attach")
public class Attach {
	private String uuid;
	private String path;
	private boolean image;
	private String origin;
	private Long bno;
	private Long mno;
	private int odr;
	
	private long size;
	
	private Long viewbno;
	public Attach(String uuid, String path, boolean image, String origin, Long bno, int odr, long size) {

		this.uuid = uuid;
		this.path = path;
		this.image = image;
		this.origin = origin;
		this.bno = bno;
		this.odr = odr;
		this.size = size;


	}

	
	public String getS3Key() {
	    return "upload/" + this.path + "/" + this.uuid;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj) return true;
		if (obj == null || getClass() != obj.getClass()) return false;
		Attach that = (Attach) obj;
		return Objects.equals(uuid, that.uuid); // uuid 기준으로만 비교
	}

	@Override
	public int hashCode() {
		return Objects.hash(uuid);
	}
}

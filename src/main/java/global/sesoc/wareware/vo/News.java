package global.sesoc.wareware.vo;

import lombok.Data;

@Data
public class News {

	private int newsno;
	private String newsdate;
	private String popular;
	private String subject;
	private String article;
	private int sentiment;
	private String company;
	private String imgurl;
	
}

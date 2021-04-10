package config;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
public class PagingSearch {

	/** [REQUEST] 현재 페이지 번호 **/
	@Getter @Setter
    private Integer pageNo = 1;

	/** [REQUEST] 현재 범위 번호 **/
	@Getter @Setter
	private Integer rangeNo = 1;

	/** [REQUEST] 한 페이지당 게시글 수 **/
	@Getter @Setter
    private Integer pageSize = 10;

	/** [REQUEST] 한 범위(range)당 페이지 수 **/
	@Getter @Setter
    private Integer rangeSize = 10;


	/** [RESPONSE] 전체 게시글의 카운트 **/
	@Getter
	private int totalCount;

	/** [RESPONSE] 전체 페이지 카운트 **/
	@Getter
	private int pageCount;

	/** [RESPONSE] 전체 범위 카운트 **/
	@Getter
	private int rangeCount;

	/** 페이징 응답 카운트들 초기화 **/
	public final void initResponseCount( int totalCount, int pageCount, int rangeCount )  {
		this.totalCount = totalCount;
		this.pageCount = pageCount;
		this.rangeCount = rangeCount;
	}

	/** SQL LIMIT START **/
	public final Integer getStart() {
		return ( this.pageNo - 1  ) * this.pageSize;
	}

	/** SQL LIMIT LENGTH **/
	public final Integer getLength() {
		return this.pageSize;
	}





}

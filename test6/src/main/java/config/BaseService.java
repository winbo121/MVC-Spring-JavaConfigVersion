package config;

import java.math.RoundingMode;
import java.util.List;


import com.google.common.math.IntMath;


/** 기본 서비스 **/
public abstract class BaseService {


	
	/** JSP 페이징 응답값 변환 **/
	protected final <E> PagingResult<E>  convertJspPaging( PagingSearch search, List<E> pagedList, Integer totalCount  ) {

		/** 유효성 체크  **/


		/** 현재 페이지 번호 **/
		int pageNo = search.getPageNo();
		/** 한 페이지당 글 사이즈 **/
		int pageSize = search.getPageSize();
		/** 현재 범위 번호 **/
		int rangeNo = search.getRangeNo();
		/** 한 범위당 페이즈 사이즈 **/
		int rangeSize = search.getRangeSize();

		/** 페이지 전체 수량 **/
		int pageCount = IntMath.divide( totalCount , pageSize , RoundingMode.CEILING );
		/** 전체 범위 수량 **/
		int rangeCount = IntMath.divide( pageCount ,  rangeSize , RoundingMode.CEILING );

		/** search 객체 데이터 주입 **/
		search.initResponseCount( totalCount, pageCount, rangeCount );


		/** 해당범위의 시작 페이지 **/
		int startRange =( rangeNo - 1) * rangeSize + 1 ;
		/** 해당범위의 끝 페이지 **/
		int endRange = rangeNo * rangeSize;

		/** 이전 RANGE 버튼 상태 **/
		boolean prevRange = rangeNo == 1 ? false : true;

		/** 다음 RANGE 버튼 상태 **/
		boolean nextRange = endRange > pageCount ? false : true;
		if ( endRange >=  pageCount ) {
			endRange = pageCount;
			nextRange = false;
		}

		/** 이전 PAGE 버튼 상태 **/
		boolean prevPage = pageNo == 1  ? false : true;
		/** 다음 PAGE 버튼 상태 **/
		boolean nextPage = pageNo < pageCount ? true: false;

		/** 첫 페이지 버튼 활성 여부 **/
		boolean firstPage = pageNo == 1 ? false : true;

		/** 마지막 페이지 활성 여부 **/
		boolean lastPage = pageNo < pageCount ? true: false;


		return PagingResult.builder( pagedList )
											.page( pageNo )
											.startRange( startRange )
											.endRange( endRange )
											.prevRange( prevRange )
											.nextRange( nextRange  )
											.prevPage( prevPage  )
											.nextPage( nextPage  )
											.firstPage( firstPage )
											.lastPage( lastPage )
											.build();
	}





}

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jspf"%>
<%@ include file="../include/sidebar.jspf"%>
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"
	integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI="
	crossorigin="anonymous"></script>

<script type="text/javascript">

	$(document).ready(function() {
		var formObj = $("form[name='readForm']");

		// 수정 
		$("#update").on("click", function() {
			formObj.attr("action", "/community/update");
			formObj.attr("method", "get");
			formObj.submit();
		})

		// 삭제
		$("#delete").on("click", function() {
			formObj.attr("action", "/community/delete");
			formObj.attr("method", "post");
			formObj.submit();
		})

		// 취소
		$("#list").on("click", function() {

			location.href =  "/community/list";
		})
	})
	
	function fn_fileDown(fileNo){
			var formObj = $("form[name='readForm']");
			$("#FILE_NO").attr("value", fileNo);
			formObj.attr("action", "/community/fileDown");
			formObj.submit();
		}
	
</script>

<body id="body">

	<section class="signin-page account">
		<div class="container">
			<div class="row">
				<div class="box-header">
					<h3 class="box-title">게시글 읽기</h3>
				</div>

				<form name="readForm" role="form" method="post">
					<input type='hidden' id="cNo" name="cNo" value="${CommunityVO.CNo}">
					<input type="hidden" id="FILE_NO" name="FILE_NO" value=""> 						
				</form>

				<div class="form-group">
					<label for="mId">작성자</label> <input type="text" name='mId'
						class="form-control" value="${CommunityVO.MId}"
						readonly="readonly">
				</div>

				<div class="form-group">
					<label for="title">제목</label> <input type="text" name='title'
						class="form-control" value="${CommunityVO.title}"
						readonly="readonly">
				</div>

				<div class="form-group">
					<label for="content">내용</label>
					<textarea class="form-control" name="content" rows="7"
						readonly="readonly">${CommunityVO.content}</textarea>
				</div>
				
				<label>첨부파일</label>
				<div class="form-group" style="border: 1px solid #dbdbdb;">
					<c:forEach var="file" items="${file}">
						<a href="#" onclick="fn_fileDown('${file.FILE_NO}'); return false;">${file.ORG_FILE_NAME}</a>(${file.FILE_SIZE}kb)<br>
					</c:forEach>
				</div>
				
				<div class="box-footer">
				<c:if test = "${sessionScope.member.MId == CommunityVO.MId || sessionScope.member.MLevel == '2'}">
					<button type="submit" class="btn btn-main" id="update">수정</button>
					<button type="submit" class="btn btn-main" id="delete">삭제</button>
				</c:if>	
					<button type="submit" class="btn btn-main" id="list">목록</button>
				</div>
				
			</div>
		</div>
	</section>
</body>

<%@ include file="../include/footer.jspf"%>
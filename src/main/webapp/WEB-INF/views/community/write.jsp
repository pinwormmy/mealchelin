<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="../include/header.jspf"%>


<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"
	integrity="sha256-u7e5khyithlIdTpu22PHhENmPcRdFiHRjhAuHcs05RI="
	crossorigin="anonymous"></script>

<script type="text/javascript">
		$(document).ready(function(){
			
			fn_addFile();
		})
		
		
		function fn_addFile(){
			var fileIndex = 1;
			$("#fileAdd_btn").on("click", function(){
				$("#fileIndex").append("<div><input type='file' style='float:left;' name='file_"+(fileIndex++)+"'>"+"</button>"+"<button type='button' style='float:right;' id='fileDelBtn'>"+"삭제"+"</button></div>");
			});
			$(document).on("click","#fileDelBtn", function(){
				$(this).parent().remove();
				
			});
		}
	</script>


<body id="body">

    <%@ include file="../include/sidebar.jspf"%>

	<section class="signin-page account">
		<div class="container">
			<div class="row">
				<div class="content">
					<h1 class="page-name">게시글 작성하기</h1>
				</div>
				<div class="table-responsive">
					<form name="writeForm" class="text-left clearfix" method="post"
						enctype="multipart/form-data">
						<table>
							<tbody>
								<tr>
									<div class="form-group"><input type="text" name='mId' class="form-control"
										placeholder="작성자" value="${member.MId}" readonly="readonly">
										<input type="hidden" name="mLevel" value="${member.MLevel}">
									</div>
								</tr>
								<tr>
									<div class="form-group"><input type="text" name='title' class="form-control"
										placeholder="제목"></div>
								</tr>
								<tr>
									<div class="form-group"><textarea class="form-control" name="content"
											rows="15" placeholder="content"></textarea></div>
								</tr>

								<tr>
									<td id="fileIndex"></td>
								</tr>
								<tr>
									<td>
										<button type="submit" class="btn btn-main text-center">작성하기</button>
									</td>
								</tr>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
	</section>
</body>

<%@ include file="../include/footer.jspf"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ include file="./include/header.jspf"%>
<%@ include file="./include/sidebar.jspf"%>


<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">개발팀 소개</h1>
					<ol class="breadcrumb">
						<li class="active">밀슐랭 쇼핑몰 개발 프로젝트</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>

<section class="about section">
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<h2 class="mt-40">
					kh강남361 오후반 - Team1 PROJECT<br>
					<br> 밀키트 쇼핑몰 "밀슐랭"
				</h2>
				<br>
				<p>이가영 강상훈 김우석 김한얼 박진선 양지혜 정예슬 최성원</p>
			</div>
			<div class="col-md-6">
                <h2>시연 영상</h2>
                <iframe width="560" height="315" src="https://www.youtube.com/embed/eXMZk88Fi98"
                title="YouTube video player" frameborder="0" allow="accelerometer; autoplay; clipboard-write;
                encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
            </div>
		</div>
	</div>
</section>
<hr>
<section class="team-members section">
	<div class="container">
		<div class="row">
			<div class="title">
				<h2>Reference</h2>
			</div>
		</div>
		<div class="row">
			<div class="col-md-3">
				<div class="team-member text-center"></div>
			</div>
			<div class="col-md-3">
				<div class="team-member text-center">
					<a href="https://www.kurly.com/shop/main/index.php"> <img
						class="img-responsive"
						src="<%=request.getContextPath()%>/images/about/marketKurly.png"></a>
					<h4>Market Kurly</h4>
					<p>밀키트 상품 샘플 자료</p>
				</div>
			</div>
			<div class="col-md-3">
				<div class="team-member text-center">
					<a href="https://themefisher.com/"> <img class="img-responsive"
						src="<%=request.getContextPath()%>/images/about/Themefisher.png"></a>
					<h4>Themefisher</h4>
					<p>템플릿 디자인</p>
				</div>
			</div>
			<div class="col-md-3">
				<div class="team-member text-center"></div>
			</div>

		</div>
	</div>
</section>
<%@ include file="./include/footer.jspf"%>
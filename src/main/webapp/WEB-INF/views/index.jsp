<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png" href="http://example.com/myicon.png">
<!-- Basic Page Needs
  ================================================== -->
<meta charset="utf-8">
<title>밀슐랭 | 밀키트 쇼핑몰</title>
<style>
.slider-item {
    margin: 0 300px 0 200px;
}
</style>
</head>

<body id="body">

<%@ include file="./include/header.jspf"%>
<%@ include file="./include/sidebar.jspf"%>

<div class="hero-slider">
	<div class="slider-item th-fullpage hero-area"
		style="background-image: url(<%=request.getContextPath()%>/images/slider/korean.jpg);">
		<div class="container" style="height: 300px;">
			<div class="row">
				<div class="col-lg-8 text-center">
					<p data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".1">한식 KOREAN FOOD</p>
					<h1 data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".5">
						우리 입맛에 맞는 정겨운 맛
					</h1>
					<a data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".8" class="btn"
						href="<%=request.getContextPath()%>/product/listType?typeCode=1">둘러보기</a>
				</div>
			</div>
		</div>
	</div>
	<div class="slider-item th-fullpage hero-area"
		style="background-image: url(<%=request.getContextPath()%>/images/slider/western.jpg);">
		<div class="container" style="height: 300px;">
			<div class="row">
				<div class="col-lg-8 text-left">
					<p data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".1">양식 WESTERN FOOD</p>
					<h1 data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".5">
						양식에서 서양 사람들의<br> 경험과 표현을 느껴보세요
					</h1>
					<a data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".8" class="btn"
						href="<%=request.getContextPath()%>/product/listType?typeCode=2">둘러보기</a>
				</div>
			</div>
		</div>
	</div>
	<div class="slider-item th-fullpage hero-area"
		style="background-image: url(<%=request.getContextPath()%>/images/slider/chinese.jpg);">
		<div class="container" style="height: 300px;">
			<div class="row">
				<div class="col-lg-8 text-right">
					<p data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".1">중식 CHINESE FOOD</p>
					<h1 data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".5">
						다채롭고 이색적인 중화 요리
					</h1>
					<a data-duration-in=".3" data-animation-in="fadeInUp"
						data-delay-in=".8" class="btn"
						href="<%=request.getContextPath()%>/product/listType?typeCode=3">둘러보기</a>
				</div>
			</div>
		</div>
	</div>
</div>

<section class="products section bg-gray" style="padding: 0;">
	<div class="container" style="padding: 0;">
		<div class="row">
			<div class="title text-center">
				<h2>오늘의 신상</h2>
			</div>
		</div>
		<div class="row">

			<c:forEach var="productList" items="${productList}">
				<div class="col-md-4" style="width:30%; padding: 0 10px 0 10px;">
					<div class="product-item">
						<div class="product-thumb">
							<img class="img-responsive"
								src="<%=request.getContextPath()%>/product/display?fileName=${productList.thumbnail}"
								alt="product-img" />
							<div class="preview-meta">
								<ul>
									<li><a
										href="<%=request.getContextPath()%>/product/detail?pId=${productList.PId}"><i
											class="tf-ion-ios-search-strong"></i></a></li>

									<c:if test="${member == null}">
										<!-- 로그인 정보가 없을 때 -->
										<li><a
											href="<%=request.getContextPath()%>/notLoginCart.do"
											class="dropdown-toggle"><i class="tf-ion-android-cart"></i></a>
										</li>
									</c:if>
									<c:if test="${member != null}">
										<!-- 로그인 정보가 있을 때 -->
										<input type="hidden" name=mId value="${member.MId}">
                  						<input type="hidden" name="pId" value="${productList.PId}">
										<li><a
											href="<%=request.getContextPath()%>/addCart.do?mId=${member.MId}&pId=${productList.PId}&cquantity=1"><i
												class="tf-ion-android-cart"></i></a></li>
									</c:if>
								</ul>
							</div>
						</div>
						<div class="product-content">
							<h4>
								<a href="<%=request.getContextPath()%>/product/detail?pId=${productList.PId}">${productList.PName}</a>
							</h4>
							<p class="price">${productList.price}원
							</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</section>

<%@ include file="./include/footer.jspf"%>

</body>
</html>
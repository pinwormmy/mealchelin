<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jspf" %>
<%@ include file="../include/sidebar.jspf"%>
<style>
.media-body {
	line-height: 1em;
}

.media-heading a{
	font-weight:bold;
	padding-top:5px;
	color:#444;
}

.remove{
	font-weight:bold;
	color:#444;
}

</style>
<section class="page-header">
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<div class="content">
					<h1 class="page-name">주문하기</h1>
					<ol class="breadcrumb">
						<li><a href="<%=request.getContextPath()%>/index.do">메인 홈페이지</a></li>
						<li class="active">결제</li>
					</ol>
				</div>
			</div>
		</div>
	</div>
</section>
<div class="page-wrapper">
   <div class="checkout shopping">
      <div class="container">
         <div class="row">
            <div class="col-md-8">
               <div class="block billing-details">
                  <h4 class="widget-title">배송지</h4>
                  <form class="checkout-form" method="post" id="checkoutSignUp">
                     <div class="form-group">
                        <label for="full_name">이름</label>
                        <input type="text" class="form-control" id="full_name" value="${member.MName}" placeholder="">
                     </div>
                     <div class="form-group">
                        <label for="user_phone">연락처</label>
                        <input type="text" class="form-control" name="phone" id="user_phone" value="${member.phone}" placeholder="">
                     </div>
                     <div class="checkout-country-code clearfix">
                        <div class="form-group">
                           <label for="user_address">주소</label>
                           <input type="text" class="form-control" name="oAddress" id="user_address" value="${member.address}" placeholder="">
                        </div>
                        <div class="form-group" >
                           <label for="user_address">상세주소</label>
                           <input type="text" class="form-control" name="oAddress_detail" id="user_address_detail" placeholder="">
                        </div>
                     </div>
                  </form>
               </div>
               <div class="block">
                  <h4 class="widget-title">결제 수단</h4>
                  <p>신용카드 정보</p>
                  <div class="checkout-product-details">
                     <div class="payment">
                        <div class="card-details">
                           <form  class="checkout-form" id="checkoutSignUp">
                              <div class="form-group">
                                 <label for="card-number">카드 번호 <span class="required">*</span></label>
                                 <input  id="card-number" class="form-control"   type="tel" placeholder="**** **** **** ****">
                              </div>
                              <div class="form-group half-width padding-right">
                                 <label for="card-expiry">만료 기간 (MM/YY) <span class="required">*</span></label>
                                 <input id="card-expiry" class="form-control" type="tel" placeholder="MM / YY">
                              </div>
                              <div class="form-group half-width padding-left">
                                 <label for="card-cvc">CVC 번호 <span class="required">*</span></label>
                                 <input id="card-cvc" class="form-control"  type="tel" maxlength="4" placeholder="CVC" >
                              </div>
                              <a href="javascript:goCheckout();" class="btn btn-main mt-20">주문하기</a >
                           </form>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
            <div class="col-md-4">
               <div class="product-checkout-details">
                  <div class="block">
                     <h4 class="widget-title">주문 내역</h4>
                     
                     <c:set var="sumPrice" value="0" />                                          
                     <c:forEach var="cart" items="${cartList}"> 
                     
                     <div class="media product-card">
                        <a class="pull-left" href="<%=request.getContextPath()%>/shop/detail.do?pId=${cart.pId}">
                           <img class="media-object" src="<%=request.getContextPath()%>/product/display?fileName=${cart.thumbnail}" alt="Image" />
                        </a>
                        <div class="media-body">
                           <h4 class="media-heading"><a href="<%=request.getContextPath()%>/shop/detail.do?pId=${cart.pId}">${cart.pName}</a></h4>
                           <p class="price"><fmt:formatNumber value="${cart.price}" pattern="###,####,###"/>원 x ${cart.cquantity}개</p>
                           <p class="total_price">= <fmt:formatNumber value="${cart.price * cart.cquantity}" pattern="###,####,###"/>원</p>
                           <a class="remove" href="<%=request.getContextPath()%>/deleteCart.do?mId=${member.MId}&ucId=${cart.ucId}">삭제하기</a>
                        </div>
                     </div>
                     
                     <c:set var="sumPrice" value="${sumPrice + cart.cquantity * cart.price}" />
                     
                     </c:forEach>
                     <hr>
                     <div class="point-menu">
                        <span>보유포인트 : ${point.currentPoint}</span>
                        <input id="usePoint" class="form-control" placeholder="사용할 포인트" value="0">
                        잔여포인트 :<span id="remainingPoint"></span>
                     </div>
                     <hr>
                     <ul class="summary-prices">
                        <li>
                           <span>총가격:</span>
                           <span class="price"><fmt:formatNumber value="${sumPrice}" pattern="###,####,###"/>원</span>
                        </li>
                        <li>
                           <span>배송비:</span>
                           <span>무료</span>
                        </li>
                        <li>
                           <span>포인트사용:</span>
                           <span>- <span id="inputedUsePoint">0</span> 원</span>
                        </li>
                     </ul>
                     <div class="summary-total">
                        <span>Total</span>
                        <span><span id="finalPayment"><fmt:formatNumber value="${sumPrice}" pattern="###,####,###"/></span>원</span>
                     </div>
                  </div>
               </div>
            </div>
         </div>
      </div>
   </div>
</div>


<%@ include file="../include/footer.jspf" %>
   
<script type="text/javascript">

    //alert("js test04");
 
    let checkoutForm = document.getElementById("checkoutSignUp");
    let userAddressDetail = document.getElementById("user_address_detail");
    let cardNumber = document.getElementById("card-number");
    let cardExpiry = document.getElementById("card-expiry");
    let cardCvc = document.getElementById("card-cvc");
    let usePoint = document.getElementById("usePoint");
 
    function goCheckout() {
        if (userAddressDetail.value == "") {
            alert("상세주소를 입력하세요.");
            checkoutForm.user_address_detail.focus();
            return false;
        }
        if (cardNumber.value == "") {
            alert("카드 번호를 입력하세요.");
            checkout-form.card-number.focus();
            return false;
        }
        if (cardExpiry.value == "") {
            alert("카드 만료기한을 입력하세요.");
            checkout-form.card-expiry.focus();
            return false;
        }
        if (cardCvc.value == "") {
            alert("CVC번호를 입력하세요.");
            checkout-form.card-cvc.focus();
            return false;
        }
        location.href="/addOrder.do?mId=${member.MId}&usePoint=" + usePoint.value;
    }

    $('#usePoint').focusout(function() {
        let usePoint = $(this).val();
        let result = ${point.currentPoint} - usePoint;
        if(result < 0) {
            alert("보유포인트 이내로 입력해주세요~");
            $(this).val(0).focus();
        }
        $('#remainingPoint').html(result);
        $('#inputedUsePoint').html(usePoint);
        let finalResult = ${sumPrice} - usePoint
        let finalResultWithComma = $.numberWithCommas(finalResult);
        $('#finalPayment').html(finalResultWithComma);
    });

    $.numberWithCommas = function(price) { // 가격 3자리당 쉼표 찍기 표현식
        return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    }

</script>


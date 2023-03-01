<%@page import="java.awt.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  

<title>Search - Training</title>
</head>
<style type="text/css">
  <%@include file="/WEB-INF/css/common.css"%>
</style>
<style type="text/css">
  <%@include file="/WEB-INF/css/T002.css"%>
</style>
<body>

<style type="text/jsp">
  <%@include file="/WEB-INF/include/header.jsp"%>
</style>

<div class = "search-container">
	<div class = "search-container__dan">
		<div class = "search-container__text">
			Login > Search Customer
		</div>
	<div class = "search-container__context">
			<%
				 if (session.getAttribute("name") != null) {
			%>
				<div class = "search-container__logo">
					<div>Welcome <%=session.getAttribute("name") %></div>
				</div>
			<%} %>
		
		<a href = "#" class = "search-container__logout">
			Log Out
		</a>
	</div>
	
	<div class = "search-container__line"></div>
	
	
<form id = "form-Search" action ="/CustomerSystem_Servlet_Jsp/T002" method = "POST" onsubmit="return validateForm()">
	<div class = "search-container__handalSearch">
		<div class = "search-container__handalSearch--margin handalSearch-customerName">
			<div class = "handalSearch-customercommon handalSearch-customerName__text">Customer Name</div>
			<input id = "txtCustomerName" name = "txtCustomerName" maxLength = "50"/>
		</div>
		
		<div class = "search-container__handalSearch--margin handalSearch-customerSex">
			<div class = "handalSearch-customercommon handalSearch-customerSex__text">Sex</div>
			<select name="browser" id = "cboSex">
				<option value="">blank</option>
		      	<option value="0">Male</option>
		     	 <option value="1">Female</option>
			</select>
		</div>
		
		<div class = "search-container__handalSearch--margin handalSearch-BirthdayFrom">
			<div class = "handalSearch-customercommon handalSearch-BirthdayFrom__text">Birthday</div>
			<input id = "txtBirthdayForm" class = "txtCustomerValidateFROM" name = "txtBirthdayFromName" maxLength = "10"/>
			<lable class = "handalSearch-BirthdayFrom__ngangcach">～</lable>
			<input id = "txtBirthdayTo" class = "txtCustomerValidateTO" name = "txtBirthdayToName" maxLength = "10"/>
		</div>
		
		<div class = "handalSearch-btnSearch">
			<button type = "submit" id = "btnSearch">Search</button>
		</div>
	</div>
</form>
	
	<div class = "search-container__btnContext--chuyenhuong">
		<div class = "search-container__btnContext--start">
			<%
				if (request.getAttribute("listData") == null && request.getAttribute("ListA") == null) {
			%>
				<button disabled style="pointer-events: none;" id = "btnFirst"><<</button>
				<button disabled style="pointer-events: none;" id = "btnPrevious"><</button>
			<%
				}
			%>
			
			<%
				if (request.getAttribute("listData") != null) {
			%>
				<c:if test="${tag <= 1 }">
				<button id = "btnFirst" disabled style="pointer-events: none;"><a href="/CustomerSystem_Servlet_Jsp/T002?index=<%=1 %>"><<</a></button>				
					<button id = "btnPrevious" disabled style="pointer-events: none;"><a href="/CustomerSystem_Servlet_Jsp/T002?index=${tag-1}"><</a></button>
				</c:if>
				<c:if test="${tag > 1 }">	
					<button id = "btnFirst"><a href="/CustomerSystem_Servlet_Jsp/T002?index=<%=1 %>"><<</a></button>				
					<button id = "btnPrevious"><a href="/CustomerSystem_Servlet_Jsp/T002?index=${tag-1}"><</a><</button>
				</c:if>
			<%
				}
			%>

			
			<lable class = "search-container__btnContext--textstart">Previous</lable>
		</div>
		
		<div class = "search-container__btnContext--end">
			<lable class = "search-container__btnContext--textend">Next</lable>
			<%
				if (request.getAttribute("listData") == null && request.getAttribute("ListA") == null) {
			%>
				<button  disabled style="pointer-events: none; id = "btnNext">></button>
				<button disabled style="pointer-events: none; id = "btnPrevious">>></button>
			<%
				}
			%>
			
			<%
				if (request.getAttribute("listData") != null) {
					Integer endP = (Integer) request.getAttribute("endP"); // lấy giá trị endP từ request
				    int endPValue = 0;
				    if (endP != null) {
				        endPValue = endP.intValue();
				    }
			%>
					<c:if test="${tag == endPValue || listData.size() <= 15}">			
						<button id="btnNext" disabled style="pointer-events: none;"><a href="/CustomerSystem_Servlet_Jsp/T002?index=${tag+1}">></a></button>
						<button id="btnLast" disabled style="pointer-events: none;"><a href="/CustomerSystem_Servlet_Jsp/T002?index=<%= endPValue %>">>></a></button>
					</c:if>
					<c:if test="${tag < endPValue }">			
						<button id="btnNext"><a href="/CustomerSystem_Servlet_Jsp/T002?index=${tag+1}">></a></button>
						<button id="btnLast"><a href="/CustomerSystem_Servlet_Jsp/T002?index=<%= endPValue %>">>></a></button>
					</c:if>
			<%
				}
			%>

		</div>
	</div>
	<form action ="/CustomerSystem_Servlet_Jsp/T002" method = "POST">
	<table class = "search-container__table">
        <tr class = "search-container__table--tieude">
        	<th><input type="checkbox" id = "checkAll" name="checkboxAll" value="" onclick = "checkBox(this)"></th>
            <th>Customer ID</th>
            <th>Customer Name</th>
            <th>Sex</th>
            <th>Birthday</th>
            <th>Address</th>
        </tr>
        
	<c:choose>
    <c:when test="${not empty listDataSearch}">
        <c:forEach items="${listDataSearch}" var="dept">
            <tr>
                <td><input type="checkbox" name="checkboxAll" value="${dept.CUSTOMER_ID}"></td>
                <td><a href="/CustomerSystem_Servlet_Jsp/T003?id=${dept.CUSTOMER_ID}"> ${dept.CUSTOMER_ID} </a></td>
                <td>${dept.CUSTOMER_NAME }</td>
                <td>${dept.SEX}</td>
                <td>${dept.BIRTHDAY}</td>
                <td>${dept.ADDRESS}</td>
            </tr>
        </c:forEach>
    </c:when>
    <c:when test="${not empty ListA}">
        <c:forEach items="${ListA}" var="dept">
            <tr>
                <td><input type="checkbox" name="checkboxAll" value="${dept.CUSTOMER_ID}"></td>
                <td><a href="/CustomerSystem_Servlet_Jsp/T003?id=${dept.CUSTOMER_ID}"> ${dept.CUSTOMER_ID} </a></td>
                <td>${dept.CUSTOMER_NAME }</td>
                <td>${dept.SEX}</td>
                <td>${dept.BIRTHDAY}</td>
                <td>${dept.ADDRESS}</td>
            </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <c:forEach items="${listData}" var="dept">
            <tr>
                <td><input type="checkbox" name="checkboxAll" value="${dept.CUSTOMER_ID}"></td>
                <td><a href="/CustomerSystem_Servlet_Jsp/T003?id=${dept.CUSTOMER_ID}"> ${dept.CUSTOMER_ID} </a></td>
                <td>${dept.CUSTOMER_NAME }</td>
                <td>${dept.SEX}</td>
                <td>${dept.BIRTHDAY}</td>
                <td>${dept.ADDRESS}</td>
            </tr>
        </c:forEach>
    </c:otherwise>
	</c:choose>


    </table>
		
	<div class = "search-container__btnnav">
		<button class = "search-container__nav-btnAdd">Add New</button>
		<button type = "submit" class = "search-container__nav-btnAdd" onclick="deleteRows()" >Delete</button>
			
		</div>
	</div>
	</form>
</div>
<script>

function deleteRows() {
	var checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
	var checkboxesNot = document.querySelectorAll('input[type="checkbox"]:not(:checked)');
	console.log(checkboxes);
	var selectedValues = [];
	for (var i = 1; i < checkboxes.length; i++) {
		 if (checkboxes[i].checked) {
	  		selectedValues.push(checkboxes[i].value);
		} 
	}
	if (checkboxesNot.length == checkboxes.length){
		 selectedValues.shift();
	}
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
	  if (this.readyState == 4 && this.status == 200) {
	    console.log(this.responseText);
	  }
	};
	xhttp.open("POST", "/CustomerSystem_Servlet_Jsp/T002", true);
	xhttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	xhttp.send("selectedValues=" + JSON.stringify(selectedValues));
} 

function deleteData() {
	  var checkboxes = document.getElementsByName("checkboxAll");
	  var selectedIds = [];
	  for (var i = 0; i < checkboxes.length; i++) {
	    if (checkboxes[i].checked) {
	      selectedIds.push(checkboxes[i].value);
	    }
	  }
	  if (selectedIds.length > 0) {
	    var xhr = new XMLHttpRequest();
	    xhr.open("POST", "/CustomerSystem_Servlet_Jsp/T002", true);
	    xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
	    xhr.onreadystatechange = function() {
	      if (xhr.readyState == 4 && xhr.status == 200) {
	        // Xóa thành công, cập nhật lại dữ liệu trên trang hiện tại
	        location.reload();
	      }
	    }
	    xhr.send("ids=" + selectedIds.join(","));
	  }
	}
	checkBox = (source) => {
		var checkBoxAll = document.getElementsByName("checkboxAll");
		for (var i = 0; i < checkBoxAll.length; i++) {
			checkBoxAll[i].checked = source.checked;
		}
	}
	
	
	isValidDate = (txtDate) => {
		var currVal = txtDate;
		if (currVal == '') {
			return false;
		}
		 var rxDatePattern = /^(\d{4})(\/|-)(\d{1,2})(\/|-)(\d{1,2})$/; 
		 var dtArray = currVal.match(rxDatePattern); 
		 
		 if (dtArray == null) 
		      return false;
		 //check for mm/dd/yyyy format.\
		 dtMonth = dtArray[3];
		 dtDay = dtArray[5];
		 dtYear = dtArray[1];
		 
		 if (dtMonth < 1 || dtMonth > 12) {
			 return false;
		 }else if (dtDay < 1 || dtDay > 31) {
			 return false; 
		 }else if ((dtMonth==4 || dtMonth==6 || dtMonth==9 || dtMonth==11) && dtDay ==31) 
			 return false;
		 else if (dtMonth == 2) {
			 var isleap = (dtYear % 4 == 0 && (dtYear % 100 != 0 || dtYear % 400 == 0));
		        if (dtDay> 29 || (dtDay ==29 && !isleap)) 
		                return false;
		 }
		 return true;
	}
	
	function validateForm() {
		  const dateStringFrom = document.querySelector(".txtCustomerValidateFROM").value;
		  const dateStringTo = document.querySelector(".txtCustomerValidateTO").value;
		  if(!isValidDate(dateStringFrom)) {
		    alert("Invalid Birthday (From).");
		    return false;
		  }
		  if (!isValidDate(dateStringTo)) {
			  alert("Invalid Birthday (To).");
			  return false;
		  }
	  	 var dateFromUpdate = dateStringFrom.split("/").join("");
		 var dateToUpdate =  dateStringTo.split("/").join("");
		 console.log(dateFromUpdate);
		 console.log(dateToUpdate);
		 if (dateFromUpdate > dateToUpdate) {
			alert("There is an error in the range input of Birthday");
		 }
		  return true;
		}
	
	const dateFrom = document.querySelector(".txtCustomerValidateFROM").value;
	const dateTo = document.querySelector(".txtCustomerValidateTO").value;
</script>
</body>
</html>
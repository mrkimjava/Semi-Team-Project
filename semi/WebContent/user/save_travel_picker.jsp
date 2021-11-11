 
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    
<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

 

<!DOCTYPE html>
<html>
<head>
    <title>Search date from table</title>
<style type="text/css">

/*named as styles.css in link tag in html save it the same way to get the result */
 
</style>
<!-- data table -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>

<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.21/css/jquery.dataTables.min.css">

<!-- date range picker -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/jquery/latest/jquery.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/momentjs/latest/moment.min.js"></script>
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.min.js"></script>
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />


<!-- #region datatables files -->
<!-- <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.12/css/jquery.dataTables.min.css" />
 --><script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
<!-- #endregion -->


<!-- Latest compiled and minified CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">

<link rel="stylesheet" type="text/css" href="styles.css">



</head>
<body>

<div id="calender"   style="width:10px; font-size:10px;top:180px; left:570px; position:absolute; visibility:hidden;">

<div id="reportrange" class="btn btn-success btn-lg" align="center" >
    <i class="fa fa-calendar"></i>&nbsp;
    <span></span> <i class="fa fa-caret-down"></i>
</div>


</div>

<div id="tabledata" style="width:60%; top:270px; right:350px; position:absolute;">
<table id="example" class="display"  >  
				
				<col width="100px">
				<col width="130px">
				<col width="400px">
				<tr>
					<th></th>
					<th></th>
					<th></th>
				</tr>
				<c:choose>
					<c:when test="${empty wished_list }">
						<tr>
							<td colspan="3" class="blank_list"> 여행일정이 없습니다.</td>
						</tr>
					</c:when>
					<c:otherwise>
						<c:forEach items="${wished_list }" var="HeartDto">
							<tr>
								<td>${HeartDto.nation }</td>
								<td>${HeartDto.place_name }</td>
								<td>${HeartDto.place_address }</td>
							</tr>
						</c:forEach>
					</c:otherwise>
				</c:choose>	
			</table><br><br><br><br><br><br><br><br><br><br>
			  
</div>



<script type="text/javascript">

$(document).ready(function() {

  $(function() {
    var start = moment( );
    var end = moment( );

    function cb(start, end) {
      $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    }

    $('#reportrange').daterangepicker({
      startDate: start,
      endDate: end,
      ranges: {
        'Today': [moment(), moment()],
        'This Month': [moment().startOf('month'), moment().endOf('month')],
        }
    }, cb);//date rangepicker ends here

    cb(start, end);

  }); 
 

   $('#reportrange').on('apply.daterangepicker', function(ev, picker) {
    var start = picker.startDate;
    var end = picker.endDate;


      $.fn.dataTable.ext.search.push(
    function(settings, data, dataIndex) {
      var min = start;
      var max = end;
      var startDate = new Date(data[3]);
      
      if (min == null && max == null) {
        return true;
      }
      if (min == null && startDate <= max) {
        return true;
      }
      if (max == null && startDate >= min) {
        return true;
      }
      if (startDate <= max && startDate >= min) {
        return true;
      }
      return false;
    }
  ); //external search ends here

  table.draw();
  $.fn.dataTable.ext.search.pop();


        }); // report range ends here


var table = $('#example').DataTable({
    "order": [
      [0, "desc"]
    ],
    lengthChange: false,
    data: dataSet,
    columns: [{
        title: "국가"
      },
      {
        title: "장소이름"
      },
      {
        title: "주소"
      }, 
       
      

    ]
  }); //table var ends here




});// ready function ends here
 

`<c:forEach items="${wished_list }" var="HeartDto">`

var dataSet = [ 
    
   [` ${HeartDto.nation }`, `${HeartDto.place_name }`,`${HeartDto.place_address }`], q
];

`</c:forEach>`


$(document).ready(function() {
    $('#example').DataTable( {
        data: dataSet,
        columns: [
            { title: "국가" },
            { title: "장소이름" },
            { title: "주소 " }
            
        ]
    } );


} );

</script>

</body>
</html>
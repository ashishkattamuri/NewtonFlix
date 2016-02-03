<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>NewtonFlix using AngularJS</title>

<link rel="stylesheet" type="text/css" href="css/mystyle.css">
<link rel="stylesheet" type="text/css" href="css/tableColumns.css">

<script type="text/javascript" src="js/angular.min.js"></script>

<script>
var app = angular.module('myApp', []);

app.controller("MyController",function($scope, $http) {
	$scope.displayData=true;
        $scope.getDataFromServer = function(movieName,pageNum) {
	        if(typeof movieName === "undefined" || movieName.trim().length==0 )
	        	{
	        		alert("Please enter valid search terms");
	        		return;
	        	}
        	$scope.displayData=false;
        	console.log(pageNum);
        	 var name = $scope.movieName;        		              
                $http({
                        method : 'GET',
                        /* url : 'http://www.omdbapi.com/?s='+name+'&page='+ pageNum */
                        url : 'javaAngularJS?movieName='+name+'&pageNumber='+pageNum
                }).success(function(data, status, headers, config) {
                        $scope.search = data.Search;
                        $scope.pagesNum = data.totalResults / 10;
                        
                        if(data.Response == "False")
                        	{
                        		$scope.displayData=true;
                        		alert(data.Error);
                        		return;
                        	}
                        
                        console.log($scope.pagesNum);
                        $scope.pages = [];
                        for (i=1;i<=$scope.pagesNum+1;i++) {
                          $scope.pages.push({ i});
                        }
                }).error(function(data, status, headers, config) {
                        // called asynchronously if an error occurs
                        // or server returns response with an error status.
                        alert("Error:"+status);
                });

        };
});
</script>

<style>

.header{
height: 30px;
}

</style>

</head>
<body style="width: 100%;height: 100%;">
	<center>
	
		<div ng-app="myApp">
			<div ng-controller="MyController">
			
				<h2> Newton Flix </h2>
				<div class="field">
				<input placeholder="Enter the search term for movies" type="text" name="movieName" ng-model="movieName">
				<button type="button" ng-click="getDataFromServer(movieName,pageNum)"
					ng-init="pageNum='1'">Search</button>

				</div>

				<table class="column-options"  ng-hide="displayData" width='70%'>
					<tbody>
						<tr >
							<th width="80%">Title</th>
							<th width="20%">Year</th>
						</tr>
						<tr ng:repeat="i in search" ng-class-odd="'odd'" ng-class-even="'even'">
							<td width="80%"><a target=_blank href="http://www.imdb.com/title/{{i.imdbID}}">{{i.Title}}</a></td>
							<td width="20%">{{i.Year}}</td>

						</tr>
					</tbody>
				</table>
				<div>
				<div ng-repeat="p in pages" style="display:inline">
					<a href="#"  ng-click="getDataFromServer(movieName,p.i)"
						> <span style='border-style: none; background-color: rgb(22, 160, 133)'> {{p.i}} </span> </a>&nbsp
				</div>
				</div>
			</div>
		</div>
	</center>
</body>
</html>
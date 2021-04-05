@extends('layout')
@section('title')
<title>List of product</title>
@endsection
@section('content')
    <!--start-breadcrumbs-->
	<div class="breadcrumbs">
		<div class="container">
			<div class="breadcrumbs-main">
				<?php $count = 0; ?>
				@foreach ($cate as $item)
				<?php if($count == 1) break; ?>
					<ol class="breadcrumb">
						<li><a href="{{URL::to('/home')}}">Home</a></li>
						<li class="active">{{$item->Category->name}}</li>
					</ol>
				<?php $count++; ?>
				@endforeach
			</div>
		</div>
	</div>
	<!--end-breadcrumbs-->
	<!--prdt-starts-->
	<div class="prdt"> 
		<div class="container"  >
			<div class="prdt-top">
				<div class="col-md-9 prdt-left">
					<div class="product-one" id="updateDiv">
						@foreach ($cate as $item)
						<div class="col-md-4 product-left p-left">
							<div class="product-main simpleCart_shelfItem">
								<a href="{{URL::to('/product-details/'.$item->id)}}" class="mask"><img class="img-responsive zoom-img" src="{{URL::to($item->feature_image)}}" alt="" />								<div class="product-bottom">
									<h3>{{$item->name}}</h3>
									<p>Explore Now</p>
									<h5>
										<span>
										<?php
										if($item->quantity > 0){
											echo 'IN STOCK';
										}else{
											echo 'OUT OF STOCK';
										}
											
										?>
									</span>
									</h5>
									<h4><span class=" item_price">{{number_format($item->price)}} đ</span></h4>
									</a>
								</div>
							</div>
						</div>
						@endforeach
					</div>
				<div class="clearfix"></div>
			</div>
			
			<div class="col-md-3 prdt-right">
				<div class="w_sidebar">
					<section  class="sky-form">
						<h4>Catogories</h4>
						<div class="row1 scroll-pane">
							<div class="col col-4">	
								@foreach($cate_name as $item)
								<label class="checkbox"><input type="checkbox"  class="check category" name="checkbox" value="{{$item->id}}"><i></i>{{$item->name}} ({{App\Models\Product::where('category_id',$item->id)->count()}})</label>
								@endforeach
							</div>
						</div>
					</section>
					<section  class="sky-form">
						<h4>Brand</h4>
						<div class="row1 row2 scroll-pane">
							<div class="col col-4">
								@foreach ($brand_name as $item)
									<label class="checkbox"><input type="checkbox" name="checkbox"  class="check brand" value = "{{$item->id}}"><i></i>{{$item->name}} ({{App\Models\Product::where('brand_id',$item->id)->count()}})</label>		
								@endforeach				
							</div>
						</div>
					</section>
				</div>
			</div>
		</div>
		
	</div>
	<!--product-end-->
	<div style="text-align: center;">
		{{$cate->links()}}
	</div>
	
@endsection
	
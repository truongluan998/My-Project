@extends('layout')
@section('title')
<title>Home</title>
@endsection
@section('content')
<!--banner-starts-->
	<div class="bnr" id="home">
		<div  id="top" class="callbacks_container">
			<ul class="rslides" id="slider4">
			    <li>
					<img src="{{asset('frontend/images/bnr-1.jpg')}}" alt=""/>
				</li>
				<li>
					<img src="{{asset('frontend/images/bnr-2.jpg')}}" alt=""/>
				</li>
				<li>
					<img src="{{asset('frontend/images/bnr-3.jpg')}}" alt=""/>
				</li>
			</ul>
		</div>
		<div class="clearfix"> </div>
	</div>
	<!--banner-ends-->
	<!--Slider-Starts-Here-->
				<script src="{{asset('frontend/js/responsiveslides.min.js')}}"></script>
			 <script>
			    // You can also use "$(window).load(function() {"
			    $(function () {
			      // Slideshow 4
			      $("#slider4").responsiveSlides({
			        auto: true,
			        pager: true,
			        nav: true,
			        speed: 500,
			        namespace: "callbacks",
			        before: function () {
			          $('.events').append("<li>before event fired.</li>");
			        },
			        after: function () {
			          $('.events').append("<li>after event fired.</li>");
			        }
			      });

			    });
			  </script>
			<!--End-slider-script-->
	<!--about-starts-->
	<div class="about">
		<div class="container">
			<div class="about-top grid-1">
				<div class="col-md-4 about-left">
					<figure class="effect-bubba">
						<img class="img-responsive" src="{{asset('frontend/images/abt-1.jpg')}}" alt=""/>
						<figcaption>
							<h2>Nulla maximus nunc</h2>
							<p>In sit amet sapien eros Integer dolore magna aliqua</p>
						</figcaption>
					</figure>
				</div>
				<div class="col-md-4 about-left">
					<figure class="effect-bubba">
						<img class="img-responsive" src="{{asset('frontend/images/abt-2.jpg')}}" alt=""/>
						<figcaption>
							<h4>Mauris erat augue</h4>
							<p>In sit amet sapien eros Integer dolore magna aliqua</p>
						</figcaption>
					</figure>
				</div>
				<div class="col-md-4 about-left">
					<figure class="effect-bubba">
						<img class="img-responsive" src="{{asset('frontend/images/abt-3.jpg')}}" alt=""/>
						<figcaption>
							<h4>Cras elit mauris</h4>
							<p>In sit amet sapien eros Integer dolore magna aliqua</p>
						</figcaption>
					</figure>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<!--about-end-->
	<!--product-starts-->
	<div class="product">
		<div class="container">
			<div class="product-top">
				<div class="logo">
					<h2>New Arrival</h2>
				</div>
				<div class="product-one">
					@foreach ($new_product as $item)
					<div class="col-md-3 product-left">
						<div class="product-main simpleCart_shelfItem">
            
							<a href="{{URL::to('/product-details/'.$item->id)}}" class="mask"><img class="img-responsive zoom-img" src="{{URL::to($item->feature_image) }}" alt="" />

							<div class="product-bottom">
								<h3>{{$item->name}}</h3>
								<a href="{{URL::to('/product-details/'.$item->id)}}"><p>Explore Now</p></a>
								<h4><!--<a class="item_add" href="#"

									data-url="{{URL::to('/add-to-cart/'.$item->id)}}";
									><i></i></a> -->
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
							</div>
						</div>
					</div>
					@endforeach
				</div>
			</div>
		</div>
	</div>
	<!--product-end-->
	<!--information-starts-->

@endsection

<!DOCTYPE html>
<html>

<head>

    @yield('title')    
    <link href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
    <!--jQuery(necessary for Bootstrap's JavaScript plugins)-->
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <!--Custom-Theme-files-->
    <!--theme-style-->
    <link href="{{asset('frontend/css/style.css')}}" rel="stylesheet" type="text/css" media="all" />
    <!--//theme-style-->

    <script type="application/x-javascript">
        addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); }
    </script>
    <!--start-menu-->
    <script src="https://kit.fontawesome.com/80ea8b739f.js" crossorigin="anonymous"></script>
    <script src="{{asset('frontend/js/simpleCart.min.js')}}"> </script>
    <link href="{{asset('frontend/css/memenu.css')}}" rel="stylesheet" type="text/css" media="all" />
    <script type="text/javascript" src="{{asset('frontend/js/memenu.js')}}"></script>
    <script>
        $(document).ready(function(){$(".memenu").memenu();});
    </script>
    <!--dropdown-->
    <script src="{{asset('frontend/js/jquery.easydropdown.js')}}"></script>
    <script>
        simpleCart({
    currency: "BTC" // set the currency to pounds sterling
});
    </script>
    <script src="{{asset('frontend/js/sweetalert.min.js')}}"></script>

    <script>
        $(function(){
            $('.check').click(function(){
                //alert('check');
                var category =[];
                $('.category').each(function(){
                    if($(this).is(":checked")){
                        category.push($(this).val());
                    }
                });
                var brand =[];
                $('.brand').each(function(){
                    if($(this).is(":checked")){
                        brand.push($(this).val());
                    }
                });
                Finalcate  = category.toString();
                Finalbrand  = brand.toString();
                $.ajax({
                    async: true,
                    type: 'get',
                    dataType: 'html',
                    url: '',
                    data: "category=" + Finalcate +"&brand=" + Finalbrand ,
                    success: function (response) {
                        console.log(response);
                        $('#updateDiv').replaceWith($('#updateDiv',response));
                    }
                });
            });	

            // $('.brand').click(function(){
            //     //alert('check');
            //     var brand =[];
            //     $('.brand').each(function(){
            //         if($(this).is(":checked")){
            //             brand.push($(this).val());
            //         }
            //     });
            //     Final  = brand.toString();
            //     $.ajax({
            //         async: true,
            //         type: 'get',
            //         dataType: 'html',
            //         url: '',
            //         data: "brand=" + Final,
            //         success: function (response) {
            //             console.log(response);
            //             $('#updateDiv').replaceWith($('#updateDiv',response));
            //         }
            //     });
            // });
        });
    </script>

    <script src="{{asset('frontend/js/jquery.validate.min.js')}}"></script>
</head>

<body>
    <!--top-header-->
    <div class="top-header">
        <div class="container">

            <div class="top-header-main">

                <div class="col-md-6 top-header-left">

                    <ul class="nav navbar-nav">
                        @if(Auth::check())
                        <li>
                            <a href="">
                                <span class="glyphicon glyphicon-user"> My account</span>
                            </a>

                        </li>
                        <li>
                            <a href="{{url('/user/orders')}}">
                                <span class="glyphicon glyphicon-user"> My Orders</span>
                            </a>

                        </li>

                        <li>
                            <a href="/user/logout"><span class="glyphicon glyphicon-log-in"> Logout</span></a>
                        </li>

                        @else
                        <li><a href="/user/login"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                        <li><a href="/user/register"><span class="glyphicon glyphicon-user"></span> Register</a></li>

                        @endif
                    </ul>


                </div>
                <div class="col-md-6 top-header-left">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a href=""><i class="fa fa-envelope"></i> Contact</a>
                        </li>
                        <li>
                            <a href="{{URL::to('/show-cart')}}"><span class="glyphicon glyphicon-shopping-cart"></span>Cart(0)</a>
                        </li>

                    </ul>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <!--top-header-->
    <!--start-logo-->
    <div class="logo">
        <a href="{{URL::to('/home')}}">
            <h1>Luxury Watches</h1>
        </a>
    </div>
    <!--start-logo-->
    <!--bottom-header-->
    <div class="header-bottom">
        <div class="container">
            <div class="header">
                <div class="col-md-9 header-left">
                    <div class="top-nav">
                        <ul class="memenu skyblue">
                            <li class="{{ Nav::isRoute('home') }}"><a href="{{URL::to('/home')}}">Home</a></li>
                            @foreach ($product_type as $item)
                            <li class="grid {{ Nav::isResource($item->id, 'product-by-cate', NULL, FALSE) }}"><a
                                    href="{{URL::to('/product-by-cate/'.$item->id)}}">{{$item->name}}</a>
                            </li>
                            @endforeach
                            <li class="grid {{ Nav::isRoute('brand-product') }}"><a
                                    href="{{URL::to('/all-product-by-brand')}}">Brands</a>

                                <div class="mepanel">
                                    <div class="row">
                                        <div class="col1 me-one">
                                            <h4>Popular Brands</h4>
                                            <ul>
                                                @foreach ($product_brand as $key)
                                                <li><a
                                                        href="{{URL::to('/product-by-brand/'.$key->id)}}">{{$key->name}}</a>
                                                </li>
                                                @endforeach
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </li>
                            {{-- <li class="grid"><a href="contact.html">Contact</a> --}}
                            </li>
                        </ul>
                    </div>
                    <div class="clearfix"> </div>
                {{-- </div>
                <div class="col-md-3 header-right">
                    <form action="/search" class="navbar-form">
                        <div class="search-bar">
                            <div>
                                <input type="text" name="query" class="form-control search-box"
                                    placeholder="Search here">
                            </div>
                            <button type="submit" class="btn btn-default">Search</button>
                        </div>
                    </form>

                </div> --}}
                <div class="clearfix"> </div>
            </div>
        </div>
    </div>
    <!--bottom-header-->
    @yield('content')
    <hr>

    <!--information-starts-->
    <div class="information">
        <div class="container">
            <div class="infor-top" style="background-color: black;">
                <div class="col-md-3 infor-left">
                    <h3>Follow Us</h3>
                    <ul>
                        <li><a href="#"><span class="fb"></span>
                                <h6>Facebook</h6>
                            </a></li>
                        <li><a href="#"><span class="twit"></span>
                                <h6>Twitter</h6>
                            </a></li>
                        <li><a href="#"><span class="google"></span>
                                <h6>Google+</h6>
                            </a></li>
                    </ul>
                </div>
                <div class="col-md-3 infor-left">
                    <h3>Information</h3>
                    <ul>
                        <li><a href="#">
                                <p>Specials</p>
                            </a></li>
                        <li><a href="#">
                                <p>New Products</p>
                            </a></li>
                        <li><a href="#">
                                <p>Our Stores</p>
                            </a></li>
                        <li><a href="contact.html">
                                <p>Contact Us</p>
                            </a></li>
                        <li><a href="#">
                                <p>Top Sellers</p>
                            </a></li>
                    </ul>
                </div>
                <div class="col-md-3 infor-left">
                    <h3>My Account</h3>
                    <ul>
                        <li><a href="account.html">
                                <p>My Account</p>
                            </a></li>
                        <li><a href="#">
                                <p>My Credit slips</p>
                            </a></li>
                        <li><a href="#">
                                <p>My Merchandise returns</p>
                            </a></li>
                        <li><a href="#">
                                <p>My Personal info</p>
                            </a></li>
                        <li><a href="#">
                                <p>My Addresses</p>
                            </a></li>
                    </ul>
                </div>
                <div class="col-md-3 infor-left">
                    <h3>Store Information</h3>
                    <h4>The company name,
                        <span>Lorem ipsum dolor,</span>
                        Glasglow Dr 40 Fe 72.</h4>
                    <h5>+955 123 4567</h5>
                    <p><a href="mailto:example@email.com">contact@example.com</a></p>
                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <!--information-end-->
    <!--footer-starts-->
    <div class="footer">

        <div class="row">
            <!-- FOOTER CONTENT -->

            <footer class="footer-distributed">

                <div class="footer-left">

                    <img src="{{URL::to('src/images/logo.png')}}" style="width: 200px; height:
                    100px;"
                         alt="">

                    <p class="footer-links">
                        <a href="{{ url('/home') }}">Home</a>
                        ·
                            <a href="{{ URL::to('/register') }}">Sign Up</a>
                            ·
                            <a href="{{ URL::to('/user-login') }}">Login</a>
                            ·
                        {{-- <a href="{{route('contactUs')}}">Contact</a> --}}
                    </p>

                    <p class="footer-company-name">Develop by Group 3 &copy; 2021</p>
                </div>

                <div class="footer-center">

                    <div>
                        <i class="fa fa-map-marker"></i>
                        <p><span>Cach Mang Thang 8</span> Ho Chi Minh, Viet Nam</p>
                    </div>

                    <div>
                        <i class="fa fa-phone"></i>
                        <p>+84 772 260 014</p>
                    </div>

                    <div>
                        <i class="fa fa-envelope"></i>
                        <p><a href="mailto:watch-shop@company.com">watchshopgr3@gmail.com</a></p>
                    </div>

                </div>

                <div class="footer-right">

                    <p class="footer-company-about">
                        <span>About the company</span>
                        We provide watches
                    </p>

                    <div class="footer-icons">

                        <a target="_blank" href="https://www.linkedin.com/in/aleksandar-bu%C5%A1baher-430537137/"><i class="fa
                        fa-linkedin"></i></a>
                        <a target="_blank" href="https://github.com/ABusbaher/watch-shop-laravel"><i class="fa fa-github"></i></a>
                        <a target="_blank" href="https://www.facebook.com/"><i class="fa fa-facebook"></i></a>
                        <a target="_blank" href="https://twitter.com/"><i class="fa fa-twitter"></i></a>

                    </div>


                </div>
                <div class="clearfix"></div>
            </div>
        </div>
    </div>
    <!--footer-end-->
</body>
<script>
    function addToCart(event){
		event.preventDefault();
		let urlCart = $(this).data('url');
		$.ajax({
			type: "GET",
			url: urlCart,
			datatype: 'json',
			success: function (data){
				swal({
				title: "Added to cart!",
				text: "Your cart has been updated!",
				icon: "success",
				timer: 1000
});
			},
			error: function(){

			}
		});
	}

	$(function (){
		$('.item_add').on('click',addToCart);
	});
</script>

<script>

	if($(".frm-update-quantity .quantity-input").length > 0){
		$(".frm-update-quantity .quantity-input").on('click', '.btn', function(event) {
			event.preventDefault();
			var _this = $(this),
				_input = _this.siblings('input[name=product-quantity]'),
				_current_value = _this.siblings('input[name=product-quantity]').val(),
				_max_value = _this.siblings('input[name=product-quantity]').attr('data-max');
			if(_this.hasClass('btn-reduce')){
				if (parseInt(_current_value, 10) > 0) _input.val(parseInt(_current_value, 10) - 1);
			}else {
				if (parseInt(_current_value, 10) < parseInt(_max_value, 10)) _input.val(parseInt(_current_value, 10) + 1);
			}
			var form = $(_this.closest('form'));
			form.submit();
		});
	}
</script>


    var text = $("#product-quantity");
	var form = $("#myform");
	console.log(text);
	text.bind("change keyup", function() {
		if( $(this).val() > 1 )
		$("#myform").submit();
	});
</script>


</html>

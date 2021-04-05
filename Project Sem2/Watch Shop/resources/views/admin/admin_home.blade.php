@extends('admin.layout.admin')

@section('title')
<title>Main Admin</title>
@endsection

@section('css')
<link href="{{asset('admins/home/home.css')}}" rel="stylesheet" />

@endsection

@section('content')
<div class="content-wrapper">
    @include('admin.partials.content-header', ['name' => 'Dashboard', 'key' => ''])

    <div class="content">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">

                    <div class="row row-card" style="margin-left: 40px">
                        <div class="col-sm-3">
                            <div class="card text-white mb-3" style="background: #FF9141;">
                                <div class="card-header">Total Users</div>
                                <div class="card-body">

                                    <h5 class="card-title ani" id="users">{{ $users }}</h5>

                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="card text-white mb-3" style="background: #6BE631;">
                                <div class="card-header">Total Brands</div>
                                <div class="card-body">

                                    <h5 class="card-title ani" id="brand">{{ $brands }}</h5>

                                </div>
                            </div>
                        </div>

                        <div class="col-sm-3">
                            <div class="card text-white mb-3" style="background: #21E7F3;">
                                <div class="card-header">Total Categories</div>
                                <div class="card-body">

                                    <h5 class="card-title ani" id="categories">{{ $categories }}</h5>

                                </div>
                            </div>
                        </div>

                        <div class="col-sm 3">
                            <div class="card text-white mb-3" style="background: #D25353;">
                                <div class="card-header">Total Products</div>
                                <div class="card-body">

                                    <h5 class="card-title ani" id="products">{{ $products }}</h5>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="first">
                        <div class="chart">
                            <p class="report"><strong style="font-weight: bold;"> Order report last 7 days</strong>
                            <form hidden="true" class="report-d">
                                
                            </form>
                            </p>
                            <ul class="numbers">
                                <li>100</li>
                                <li>80</li>
                                <li>60</li>
                                <li>40</li>
                                <li>20</li>
                                <li>0</li>
                            </ul>
                            <ul class="bars">
                                @foreach ($orders as $order)
                                     <li>
                                        <div class="bar" data-percentage="{{ $order->total }}"></div><span>{{ $order->created_date }}</span>
                                    </li>
                                @endforeach
                            </ul>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

@endsection

@section('js')
 <script>
                $('.ani').each(function () {
                    $(this).prop('Counter', 0).animate({
                        Counter: $(this).text()
                    }, {
                        duration: 1000,
                        easing: 'swing',
                        step: function (now) {
                            $(this).text(Math.ceil(now));
                        }
                    });
                });
            </script>

           
            <script type="text/javascript">
                $(function () {
                    $('.bars li .bar').each(function (key, bar) {
                        var percentage = $(this).data('percentage');
                        $(this).animate({
                            'height': percentage + '%'
                        }, 1000);
                    });
                });
            </script>
@endsection
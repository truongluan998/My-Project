@extends('layout')
@section('title')
<title>Checkout</title>
@endsection
@section('content')
<div class="container">
    <script>
        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (function () {
        'use strict'

        window.addEventListener('load', function () {
            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            var forms = document.getElementsByClassName('needs-validation')

            // Loop over them and prevent submission
            Array.prototype.filter.call(forms, function (form) {
            form.addEventListener('submit', function (event) {
                if (form.checkValidity() === false) {
                event.preventDefault()
                event.stopPropagation()
                }
                form.classList.add('was-validated')
            }, false)
            })
        }, false)
        }())
    </script>
    <div class="py-5 text-center">
        <h2>Checkout form</h2>
    </div>
    <div class="row">
        <div class="col-md-4 order-md-2 mb-4">
            <h4 class="d-flex justify-content-between align-items-center mb-3">
                <span class="text-muted">Your cart</span>
                <span class="badge badge-secondary badge-pill">{{Cart::count()}}</span>
            </h4>
            <ul class="list-group mb-3 sticky-top">
                @foreach (Cart::content() as $item)
                <li class="list-group-item d-flex justify-content-between lh-condensed">
                    <div>
                        <h6 class="my-0"><span style="font-size:17px;">{{$item->name}}</span> x {{$item->qty}}</h6>
                        <small class="text-muted">{{$item->options->content}}</small>
                    </div>
                    <span class="text-muted">{{number_format($item->price)}} VND</span>
                </li>
                @endforeach
                <li class="list-group-item d-flex justify-content-between">
                    <span>Total (VND)</span>
                    <strong>{{number_format(Cart::total())}} VND</strong>
                </li>
            </ul>
        </div>
        <div class="col-md-8 order-md-1">
            <h4 class="mb-3">Billing address</h4>
            <form class="needs-validation" novalidate="" method="POST" action="{{URL::to('/store-shipping-information')}}">
                 {{ csrf_field() }}
                {{-- <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="firstName">First name</label>
                        <input type="text" class="form-control" id="firstName" placeholder="" value="" required="">
                        <div class="invalid-feedback"> Valid first name is required. </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="lastName">Last name</label>
                        <input type="text" class="form-control" id="lastName" placeholder="" value="" required="">
                        <div class="invalid-feedback"> Valid last name is required. </div>
                    </div>
                </div> --}}
                <div class="mb-3">
                    <label for="name">Name* <span class="text-muted">(Required)</span></label>
                    <input type="text" class="form-control" name="name" placeholder="you@example.com">
                    <div class="invalid-feedback"> Please enter your name. </div>
                </div>
                <div class="mb-3">
                    <label for="email">Email* <span class="text-muted">(Required)</span></label>
                    <input type="email" class="form-control" name="email" placeholder="you@example.com">
                    <div class="invalid-feedback"> Please enter a valid email address for shipping updates. </div>
                </div>
                <div class="mb-3">
                    <label for="address">Address*</label>
                    <input type="text" class="form-control" name="address" placeholder="Your address" required="">
                    <div class="invalid-feedback"> Please enter your shipping address. </div>
                </div>
                {{-- <div class="row">
                    <div class="col-md-5 mb-3">
                        <label for="country">City</label>
                        <select class="custom-select d-block w-100" id="country" required="">
                            <option value="">Choose...</option>
                                <option value="An Giang">An Giang</option>
                                <option value="B?? R???a - V??ng T??u">B?? R???a - V??ng T??u</option>
                                <option value="B???c Giang">B???c Giang</option>
                                <option value="B???c K???n">B???c K???n</option>
                                <option value="B???c Li??u">B???c Li??u</option>
                                <option value="B???c Ninh">B???c Ninh</option>
                                <option value="B???n Tre">B???n Tre</option>
                                <option value="B??nh ?????nh">B??nh ?????nh</option>
                                <option value="B??nh D????ng">B??nh D????ng</option>
                                <option value="B??nh Ph?????c">B??nh Ph?????c</option>
                                <option value="B??nh Thu???n">B??nh Thu???n</option>
                                <option value="B??nh Thu???n">B??nh Thu???n</option>
                                <option value="C?? Mau">C?? Mau</option>
                                <option value="Cao B???ng">Cao B???ng</option>
                                <option value="?????k L???k">?????k L???k</option>
                                <option value="?????k N??ng">?????k N??ng</option>
                                <option value="??i???n Bi??n">??i???n Bi??n</option>
                                <option value="?????ng Nai">?????ng Nai</option>
                                <option value="?????ng Th??p">?????ng Th??p</option>
                                <option value="Gia Lai">Gia Lai</option>
                                <option value="H?? Giang">H?? Giang</option>
                                <option value="H?? Nam">H?? Nam</option>
                                <option value="H?? T??nh">H?? T??nh</option>
                                <option value="H???i D????ng">H???i D????ng</option>
                                <option value="H???u Giang">H???u Giang</option>
                                <option value="H??a B??nh">H??a B??nh</option>
                                <option value="H??ng Y??n">H??ng Y??n</option>
                                <option value="Kh??nh H??a">Kh??nh H??a</option>
                                <option value="Ki??n Giang">Ki??n Giang</option>
                                <option value="Kon Tum">Kon Tum</option>
                                <option value="Lai Ch??u">Lai Ch??u</option>
                                <option value="L??m ?????ng">L??m ?????ng</option>
                                <option value="L???ng S??n">L???ng S??n</option>
                                <option value="L??o Cai">L??o Cai</option>
                                <option value="Long An">Long An</option>
                                <option value="Nam ?????nh">Nam ?????nh</option>
                                <option value="Ngh??? An">Ngh??? An</option>
                                <option value="Ninh B??nh">Ninh B??nh</option>
                                <option value="Ninh Thu???n">Ninh Thu???n</option>
                                <option value="Ph?? Th???">Ph?? Th???</option>
                                <option value="Qu???ng B??nh">Qu???ng B??nh</option>
                                <option value="Qu???ng Ng??i">Qu???ng Ng??i</option>
                                <option value="Qu???ng Ninh">Qu???ng Ninh</option>
                                <option value="Qu???ng Tr???">Qu???ng Tr???</option>
                                <option value="S??c Tr??ng">S??c Tr??ng</option>
                                <option value="S??n La">S??n La</option>
                                <option value="T??y Ninh">T??y Ninh</option>
                                <option value="Th??i B??nh">Th??i B??nh</option>
                                <option value="Th??i Nguy??n">Th??i Nguy??n</option>
                                <option value="Thanh H??a">Thanh H??a</option>
                                <option value="Th???a Thi??n Hu???">Th???a Thi??n Hu???</option>
                                <option value="Ti???n Giang">Ti???n Giang</option>
                                <option value="Tr?? Vinh">Tr?? Vinh</option>
                                <option value="Tuy??n Quang">Tuy??n Quang</option>
                                <option value="V??nh Long">V??nh Long</option>
                                <option value="V??nh Ph??c">V??nh Ph??c</option>
                                <option value="Y??n B??i">Y??n B??i</option>
                                <option value="Ph?? Y??n">Ph?? Y??n</option>
                                <option value="Tp.C???n Th??">Tp.C???n Th??</option>
                                <option value="Tp.???? N???ng">Tp.???? N???ng</option>
                                <option value="Tp.H???i Ph??ng">Tp.H???i Ph??ng</option>
                                <option value="Tp.H?? N???i">Tp.H?? N???i</option>
                                <option value="TP  HCM">TP HCM</option>
                        </select>
                        <div class="invalid-feedback"> Please select a valid City. </div>
                    </div>
                    <div class="col-md-4 mb-3">
                        <label for="state">State</label>
                        <select class="custom-select d-block w-100" id="state" required="">
                                
                        </select>
                        <div class="invalid-feedback"> Please provide a valid state. </div>
                    </div>
                </div> --}}
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="city">City*</label>
                        <input type="text" class="form-control" name="city" placeholder="Your city" value="" required="">
                        <div class="invalid-feedback"> Valid city is required. </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="district">District*</label>
                        <input type="text" class="form-control" name="district" placeholder="Your district" value="" required="">
                        <div class="invalid-feedback"> Valid district is required. </div>
                    </div>
                </div>
                <div class="mb-3">
                   <label for="phone">Phone*<span class="text-muted">(Required)</span></label>
                   <input type="text" class="form-control" name="phone" placeholder="Input your phone number" required>
                   <div class="invalid-feedback"> Please enter your phone number. </div>   
               </div>
                {{-- <h4 class="mb-3">Payment</h4>
                <div class="d-block my-3">
                    <div class="custom-control custom-radio">
                        <input id="credit" name="paymentMethod" type="radio" class="custom-control-input" checked="" required="">
                        <label class="custom-control-label" for="credit">Credit card</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="debit" name="paymentMethod" type="radio" class="custom-control-input" required="">
                        <label class="custom-control-label" for="debit">Debit card</label>
                    </div>
                    <div class="custom-control custom-radio">
                        <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" required="">
                        <label class="custom-control-label" for="paypal">PayPal</label>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="cc-name">Name on card</label>
                        <input type="text" class="form-control" id="cc-name" placeholder="" required="">
                        <small class="text-muted">Full name as displayed on card</small>
                        <div class="invalid-feedback"> Name on card is required </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="cc-number">Credit card number</label>
                        <input type="text" class="form-control" id="cc-number" placeholder="" required="">
                        <div class="invalid-feedback"> Credit card number is required </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-3 mb-3">
                        <label for="cc-expiration">Expiration</label>
                        <input type="text" class="form-control" id="cc-expiration" placeholder="" required="">
                        <div class="invalid-feedback"> Expiration date required </div>
                    </div>
                    <div class="col-md-3 mb-3">
                        <label for="cc-cvv">CVV</label>
                        <input type="text" class="form-control" id="cc-cvv" placeholder="" required="">
                        <div class="invalid-feedback"> Security code required </div>
                    </div>
                </div> --}}
                <hr class="mb-4">
                <a href="javascript:;" class="simpleCart_empty"><input class="btn btn-primary btn-lg btn-block btn-checkout" type="submit" value="Confirm your order"></a>
            </form>
        </div>
    </div>
</div>
@endsection
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Document</title>
    <style>
        body,
        html, 
        .body {
          background: #f3f3f3 !important;
        }
      
        section {
        margin: 5%;
        }
        table {
          padding: 1px;
          border: 1px solid black;
          border-spacing: 0px;
          width: 400px;
          text-align: center;
        }
    </style>
</head>
<body>
    <section>
        <style type="text/css">
        </style>
      
        <container>
            <h1>WATCHSHOP</h1>
            
          <spacer size="16"></spacer>
      
          <row>
            <columns>
              <h2>Thank you for your order.</h2>
              <p>Thanks for shopping with us! Below is your shipping details:  </p>
      
              <spacer size="16"></spacer>
      
              <callout>
                <row>
                  <columns large="6">
                    <p>
                      <strong>Date</strong><br/> {{$order->created_at}}
                    </p>
                    <p>
                      <strong>Payment Method</strong><br/> COD
                    </p>
                    <p>
                      <strong>Email Address</strong><br/> {{$order->customer_email}}
                    </p>
                    <p>
                      <strong>Order ID</strong><br/> {{$order->id}}
                    </p>
                  </columns>
                  <columns large="6">
                    <p>
                      <strong>Shipping Address</strong><br/> {{$name}}<br/> {{$order->customer_address}}<br/> District: {{$order->customer_district}}<br/> City: {{$order->customer_city}}
                    </p>
                  </columns>
                </row>
              </callout>
      
              <h4>Order Details</h4>
      
              <table>
                <tr>
                  <th>Item</th>
                  <th>Quantity</th>
                  <th>Price</th>
                </tr>
                @foreach ($item as $key)
                <tr>
                    <td>{{$key->product->name}}</td>
                    <td>{{$key->quantity}}</td>
                    <td>{{number_format($key->product->price)}}</td>
                </tr>
                @endforeach
      
                <td colspan="2"><b>Subtotal:</b></td>
                <td>{{number_format($order->total)}}</td>
                </tr>
              </table>
      
              <hr/>
            </columns>
          </row>
          <row class="footer text-center">
            <columns large="3">
      
            </columns>
            <columns large="3">
              <p>
                Call us at 0772260014<br/> Email us at watchshopgr3@gmail.com
              </p>
            </columns>
            <columns large="3">
              <p>
                Cach mang thang tam, Ho Chi Minh City, Viet Nam<br/>
      
              </p>
            </columns>
          </row>
        </container>
      </section>
</body>
</html>
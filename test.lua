--local lustache = require 'lustache'
local amount = 0
local destinationId = '8121717844'
local bill = 0

if request.query.amount then
	amount = request.query.amount
end

if request.query.destinationId then
	destinationId = request.query.destinationId
end

if request.query.bill then
	bill = request.query.bill
end

local total = amount/100

local view = {
	title = "740 i rent ez",
	data_amount = amount * 100,
	amount = amount,
	destinationId = destinationId,
	bill = bill,
	entries = {{
		link = 'http://www.bombaytasty.com/wp-content/uploads/2014/10/Chapati.jpg',
		title = 'Roti'}, {
		link = 'http://yummyindiankitchen.com/wp-content/uploads/2016/11/masur-ki-dal-massor-daal.jpg',
		title = 'Daal'}, {
		link = 'www.yahoo.com',
		title = 'YAHOO'
	}}
}

local template = [[
<!doctype html>
<html>
<head>
	<title>{{title}}</title>

	<!--Bootstrap-->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">

	<!--Mobile Display Optimization-->
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

	<!--Jquery-->
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>

	<!--Stripe-->
	<script src="https://checkout.stripe.com/checkout.js"></script>


</head>

<body>
<div class='container'>

<h2>740 i rent ez</h2>

<form action="http://740irentez.webscript.io/oauth/dwolla/checkout"
	method="post" enctype="multipart/form-data"><!-- class="form-inline"-->
	<div class="form-group text-left">
		<div class="form-group row">
			<label class="sr-only" for="demoFlag">Demonstration Mode</label>
			<label for="demoFlag">Demonstration Mode </label><br/>
			<div class="col-xs-1">
				<input type="checkbox" name="demoFlag" checked>
			</div>
		</div>
		<div class="form-group row">
			<label class="sr-only" for="destinationId">Dwolla Id</label>
			<label for="destinationId">Landlord's Dwolla Id</label><br/>
			<div class="col-xs-1">
				<input type="text" name="destinationId" class="form-control" value="{{destinationId}}">
			</div>
		</div>
		<div class="form-group row">
		<label for="email">Landlord's Email</label><br/>

		<div class="col-xs-1">
				<input type="text" name="email" class="form-control" id="email" placeholder="joe@example.com">
			</div>
		</div>
		<div class="form-group row">
		<label for="total">Amount of Rent</label>
		<span class="input-group-addon">$</span>
			<div class="col-xs-1">
				<input type="number" name="payAmount" step="0.01" id='input_A' class="form-control" required>
			</div>
			
		</div>

		<button type="submit" class="btn btn-primary">Pay with Bank</button>
	</div>
</form>



<!--form action="https://317uvezpay.webscript.io/pay/stripe" method="post">
<script src="https://button.stripe.com/v1/button.js"
		data-key="pk_test_2O75x69mDsK1c8M4BerNdYMC"
		data-amount="{{data_amount}}" class="stripe-button"></script>
	<div class="form-group row">
		<span class="input-group-addon">$</span>
		<div class="col-xs-1">
			<input type="hidden" name="total" id='input_B' class="form-control" readonly>
		</div>
		<div class="col-xs-1">
				<input type="text" name="email" class="form-control">

		</div>
	</div>
</form-->

<!--button class="btn btn-primary btn-md" id="stripe-button">
Pay with Card <span class="glyphicon glyphicon-shopping-cart"></span>
</button>

      <script>
        $('#stripe-button').click(function(){
          var token = function(res){
            var $id = $('<input type=hidden name=stripeToken />').val(res.id);
            var $email = $('<input type=hidden name=stripeEmail />').val(res.email);
            $('form').append($id).append($email).submit();
          };

          var amount = $("#input_A").val() * 100;
          StripeCheckout.open({
            key:         'pk_test_2O75x69mDsK1c8M4BerNdYMC',
            amount:      amount,
            name:        'Serendipity Artisan Blends',
            //image:       '{% static "img/marketplace.png" %}',
            description: 'Purchase Products',
            panelLabel:  'Checkout',
            token:       token
          });

          return false;
        });
      </script>
-->

<form action="https://www.paypal.com/cgi-bin/webscr" method="post">

  <!-- Identify your business so that you can collect the payments. -->
  <input type="hidden" name="business" id='paypalEmail'>

  <!-- Specify a Buy Now button. -->
  <input type="hidden" name="cmd" value="_xclick">

  <!-- Specify details about the item that buyers will purchase. -->
  <input type="hidden" name="item_name" value="Hot Sauce-12oz. Bottle">
  <input type="hidden" name="amount" id="input_C">
  <input type="hidden" name="currency_code" value="USD">

  <!-- Display the payment button. -->
  <input type="image" name="submit" border="0"
  src="https://www.paypalobjects.com/webstatic/en_US/i/btn/png/btn_buynow_107x26.png"
  alt="Buy Now">
  <img alt="" border="0" width="1" height="1"
  src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" >

</form>

</div>

<div class="text-center">
<h3>740irentez<br/>
programmed & maintained by:<br/>
<a href="http://varshneyandsons.wordpress.com/contact" target="_blank" rel="noopener noreferrer">&#92;///&#92; //</a>
</div>

<script>

<!--2-way Bind-->

$("#input_A").on("keyup paste", function() {
    $("#input_B").val($(this).val());
		$('#input_C').val($(this).val());
});

$("#email").on("keyup paste", function() {
    $("#paypalEmail").val($(this).val());
});

</script>



</body>
</html>
]]

return lustache:render(template, view),
	{['Content-Type']='text/html; charset=utf-8'}
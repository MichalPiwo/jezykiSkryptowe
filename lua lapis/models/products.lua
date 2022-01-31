local tablex = require 'pl.tablex'

local products = {}

local makeproductsCollection = function(product_names)
  	local last_id = #products
  	local readings = tablex.map(
    	function(x)
    		last_id = last_id + 1
      		return {
	    	  id = last_id,
	    	  product_name = x["product_name"],
	    	  category_id = x["category_id"],
	    	  price = x["price"]
      		}
    	end, product_names )
  	return readings
end

local start_products = 
	{
		{
			product_name = "mleko",
			category_id = "0",
			price = "2.99"
		},
		{
			product_name = "mydlo",
			category_id = "1",
			price = "9.99"
		},
	}

local productsCollection = makeproductsCollection(start_products)

function products.getproducts(id)
	if(id < 0) then
		return productsCollection
	else
		if(id <= #productsCollection) then
			if(productsCollection[id] == nil) then	
				return	nil
			else	
			    return {id, productsCollection[id]}
			end
		else
			return nil
		end
	end
end

function products.addProduct(product_name, category_id, price)
	local cat_id = #productsCollection+1
	local prod = {id = cat_id, product_name = product_name, 
		category_id = category_id, price = price}
    productsCollection[cat_id] = prod
end


function products.updateProduct(id, product_name, category_id, price)
	if(#productsCollection >= id and id > 0) then
		local prod = {id = id, product_name = product_name, 
		category_id = category_id, price = price}
    productsCollection[id] = prod
	end
end

function products.deleteProduct(id)
	if(#productsCollection >= id and id > 0) then
		productsCollection[id] = nil
	end
end

return products
import React, { useEffect, useState } from "react";

export default function App() {
  const [products, setProducts] = useState([]);
  const [cartItems, setCartItems] = useState([]);
  const [total, setTotal] = useState([]);

  const getProducts = () => {
    $.ajax({
      url: "/pages/products",
      success: (response) => setProducts([...response.data]),
    });
  };

  const totalizeProducts = () => {
    $.ajax({
      url: "/pages/totalize_products",
      method: "POST",
      data: { items: JSON.stringify(cartItems) },
      success: (response) => setTotal(response.total),
    });
  };

  const handleSetCartItems = (product) => {
    if (product.code === "CF1") {
      setCartItems((lastItems) => ({
        ...lastItems,
        [product.code]: lastItems[product.code]
          ? lastItems[product.code] + 2
          : 2,
      }));
    } else if (product.code === "CH1" && !cartItems.MK1) {
      setCartItems((lastItems) => ({
        ...lastItems,
        [product.code]: lastItems[product.code]
          ? lastItems[product.code] + 1
          : 1,
        MK1: 1,
      }));
    } else {
      setCartItems((lastItems) => ({
        ...lastItems,
        [product.code]: lastItems[product.code]
          ? lastItems[product.code] + 1
          : 1,
      }));
    }
  };

  useEffect(() => {
    getProducts();
  }, []);

  useEffect(() => {
    totalizeProducts();
  }, [cartItems]);

  if (products.length < 0) return "Loading...";

  return (
    <div className="content-wrapper">
      <div className="product-list">
        <h3>Product List</h3>
        {products.map((product) => (
          <div key={product.id} className="product">
            <p>
              {product.name} - $: {Number(product.price).toFixed(2)}
            </p>
            <button onClick={() => handleSetCartItems(product)}>Add</button>
          </div>
        ))}
      </div>
      <button onClick={() => setCartItems([])}>Clear Cart</button>
      <div className="cart">
        <h3>Cart</h3>
        {Object.keys(cartItems).map((obj, i) => (
          <div className="product" key={i}>
            <p>{obj}</p>
            <p>{cartItems[obj]}</p>
          </div>
        ))}
        <p>$: {Number(Math.round(total + "e2") + "e-2").toFixed(2)}</p>
      </div>
    </div>
  );
}

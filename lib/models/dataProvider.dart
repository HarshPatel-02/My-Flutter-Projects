import 'ProductModel.dart';


// List<ProductItem> cartItems=[];

var globalProductList = [



  ProductItem(
      id: 1,
      title: "Modern Velvet\nArmchair",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/23/dd/0b/23dd0b36daf1da11e4179f35002a11a0.jpg",
      price: "200",
      rating: "3.6",
      description: "A stylish velvet armchair with plush cushioning and a sturdy wooden frame, adding luxury and comfort to your bedroom space."),

  ProductItem(
      id: 2,
      title: "Luxury King Bed",
      category: "Bedroom",
      img: "https://i.pinimg.com/474x/8e/ff/6c/8eff6c3635847fc59449975ea7b0b25d.jpg",
      price: "200",
      rating: "4.1",
      description: "A premium king-size bed with an elegant wooden frame, soft fabric upholstery, and a high-quality mattress for restful sleep."),

  ProductItem(
      id: 3,
      title: "Wooden Nightstand",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/d6/ca/df/d6cadfcad8fb1249ed913c026b3f6527.jpg",
      price: "250",
      rating: "3.9",
      description: "A modern wooden nightstand with a sleek design, spacious drawers, and a smooth finish, perfect for storing essentials beside your bed."),

  ProductItem(
      id: 4,
      title: "Stylish Dresser",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/67/01/6a/67016a346050ce6bf8e872b098a280ff.jpg",
      price: "250",
      rating: "4.7",
      description: "A contemporary dresser with multiple storage compartments, crafted from high-quality wood to keep your bedroom organized in style."),

  ProductItem(
      id: 5,
      title: "Cozy Bean Bag",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/67/01/6a/67016a346050ce6bf8e872b098a280ff.jpg",
      price: "300",
      rating: "5.0",
      description: "A soft and cozy bean bag filled with premium memory foam, providing ultimate comfort and relaxation in any corner of your bedroom."),

  ProductItem(
      id: 6,
      title: "Elegant Wardrobe",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/67/01/6a/67016a346050ce6bf8e872b098a280ff.jpg",
      price: "300",
      rating: "4.6",
      description: "A spacious and elegant wardrobe with a modern finish, featuring adjustable shelves and a smooth sliding door for easy access."),

  ProductItem(
      id: 7,
      title: "Soft Cotton Blanket",
      category: "Bedroom",
      img: "https://i.pinimg.com/474x/8e/ff/6c/8eff6c3635847fc59449975ea7b0b25d.jpg",
      price: "350",
      rating: "5.0",
      description: "A premium cotton blanket with ultra-soft fabric, breathable material, and a cozy feel for warm and comfortable sleep."),

  ProductItem(
      id: 8,
      title: "Hanging Pendant Light",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/d6/ca/df/d6cadfcad8fb1249ed913c026b3f6527.jpg",
      price: "350",
      rating: "4.2",
      description: "A stylish pendant light with a minimalist design, providing warm ambient lighting to enhance the aesthetic of your bedroom."),

  ProductItem(
      id: 9,
      title: "Bedside Lamp",
      category: "Bedroom",
      img: "https://i.pinimg.com/474x/c7/b1/75/c7b17545c8259bde6ac586547643efe1.jpg",
      price: "400",
      rating: "3.8",
      description: "A modern bedside lamp with adjustable brightness, a sleek design, and soft lighting for a cozy and relaxing atmosphere."),

  ProductItem(
      id: 10,
      title: "Classic Wooden Chair",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/8b/9f/53/8b9f53fb3422155d692965b17e01ea3f.jpg",
      price: "400",
      rating: "4.6",
      description: "A timeless wooden chair with an ergonomic design and sturdy frame, offering both style and comfort for your bedroom."),

  ProductItem(
      id: 11,
      title: "Elegant Ceiling Fan",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/14/46/e6/1446e6622ca5c8e5ebb3800fa7c7adad.jpg",
      price: "450",
      rating: "4.6",
      description: "A sleek and energy-efficient ceiling fan with a noiseless motor and modern design, ensuring a refreshing airflow in your bedroom."),

  ProductItem(
      id: 12,
      title: "Wooden Study Desk",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/c3/45/e9/c345e93088616d20d601341432a406b0.jpg",
      price: "450",
      rating: "4.2",
      description: "A functional and stylish study desk made from premium wood, featuring ample workspace and storage drawers for convenience."),

  ProductItem(
      id: 13,
      title: "Cozy Floor Rug",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/23/dd/0b/23dd0b36daf1da11e4179f35002a11a0.jpg",
      price: "500",
      rating: "4.3",
      description: "A soft and fluffy floor rug with a plush texture, adding warmth and elegance to your bedroom decor."),

  ProductItem(
      id: 14,
      title: "Minimalist Wall Shelf",
      category: "Bedroom",
      img: "https://i.pinimg.com/236x/d5/b2/03/d5b20325cd5ff3004421fc7192672c2e.jpg",
      price: "500",
      rating: "5.0",
      description: "A sleek and modern wall shelf with a minimalist design, perfect for displaying decorative items or storing essentials."),

  ProductItem(
      id: 15,
      title: "Elegant Sofa Set",
      category: "Living",
      img: "https://i.pinimg.com/474x/ed/66/f9/ed66f911608688aba22b3ef54500bcc0.jpg",
      price: "200",
      rating: "3.6",
      description: "A luxurious and comfortable sofa set with plush cushions and a modern design, perfect for a stylish living room."),

  ProductItem(
      id: 16,
      title: "Luxury Coffee Table",
      category: "Living",
      img: "https://i.pinimg.com/236x/f5/c0/2a/f5c02ae5df7ca6a01d89b9dfb74f7c83.jpg",
      price: "200",
      rating: "4.1",
      description: "A sleek and stylish coffee table with a glossy finish, adding elegance to your living space."),

  ProductItem(
      id: 17,
      title: "Modern TV Cabinet",
      category: "Living",
      img: "https://i.pinimg.com/236x/25/2f/9b/252f9b052d93331c52302210cd89365e.jpg",
      price: "250",
      rating: "3.9",
      description: "A contemporary TV cabinet with ample storage, a clean design, and high-quality wood construction."),

  ProductItem(
      id: 18,
      title: "Contemporary Bookshelf",
      category: "Living",
      img: "https://i.pinimg.com/236x/52/c6/4f/52c64f444513e5f64cc98988b078ff82.jpg",
      price: "250",
      rating: "4.7",
      description: "A stylish bookshelf with multiple tiers, offering both storage and display for your favorite books and decor."),

  ProductItem(
      id: 19,
      title: "Cozy Recliner Chair",
      category: "Living",
      img: "https://i.pinimg.com/236x/16/f3/c1/16f3c102b264ee8f55813aa59bc49f07.jpg",
      price: "300",
      rating: "5.0",
      description: "A comfortable and ergonomic recliner chair with a soft cushion, ideal for relaxing in your living room."),

  ProductItem(
      id: 20,
      title: "Stylish Ottoman",
      category: "Living",
      img: "https://i.pinimg.com/236x/c5/19/ce/c519cea4b3bfd866c56ccffeb3759d8a.jpg",
      price: "300",
      rating: "4.6",
      description: "A modern ottoman with a minimalist design, providing additional seating or a footrest for extra comfort."),

  ProductItem(
      id: 21,
      title: "Glass Coffee Table",
      category: "Living",
      img: "https://i.pinimg.com/236x/25/fb/ef/25fbef6fb96c5e9e8b5a7c0c94b9d054.jpg",
      price: "350",
      rating: "5.0",
      description: "A contemporary glass coffee table with a sleek metal frame, adding a modern touch to your living space."),

  ProductItem(
      id: 22,
      title: "Minimalist TV Stand",
      category: "Living",
      img: "https://i.pinimg.com/236x/44/95/bc/4495bc4a43cab3173e48dba473954843.jpg",
      price: "350",
      rating: "4.2",
      description: "A simple yet elegant TV stand with open shelving for easy storage and a modern aesthetic."),

  ProductItem(
      id: 23,
      title: "Rustic Wooden Bench",
      category: "Living",
      img: "https://i.pinimg.com/236x/35/e9/f3/35e9f3c7c951961b1a7c4ca1c937568c.jpg",
      price: "400",
      rating: "3.8",
      description: "A beautifully crafted wooden bench with a rustic finish, adding warmth and charm to your home."),

  ProductItem(
      id: 24,
      title: "Vintage Armchair",
      category: "Living",
      img: "https://i.pinimg.com/236x/00/ef/3e/00ef3e28bb809dd2afdc1156e4c91e7b.jpg",
      price: "400",
      rating: "4.6",
      description: "A vintage-style armchair with comfortable upholstery and a solid wood frame, perfect for a classic look."),

  ProductItem(
      id: 25,
      title: "Chic Floor Lamp",
      category: "Living",
      img: "https://i.pinimg.com/236x/e5/92/8c/e5928c66ff9d17d41a8dfa46bc8950cd.jpg",
      price: "450",
      rating: "4.6",
      description: "A stylish floor lamp with a modern design, providing warm and cozy lighting for any space."),

  ProductItem(
      id: 26,
      title: "Boho Wall Decor",
      category: "Living",
      img: "https://i.pinimg.com/236x/f6/bc/f8/f6bcf8bccaf5e2155b713f52af5bcd7a.jpg",
      price: "450",
      rating: "4.2",
      description: "A beautiful bohemian-inspired wall decor piece, enhancing the aesthetic appeal of your living room."),

  ProductItem(
      id: 27,
      title: "Luxury Carpet",
      category: "Living",
      img: "https://i.pinimg.com/236x/04/ac/33/04ac3349a8ea5c9ca3c4442768650194.jpg",
      price: "500",
      rating: "4.3",
      description: "A plush and elegant carpet with intricate detailing, adding comfort and sophistication to your living room."),

  ProductItem(
      id: 28,
      title: "Minimalist Wall Shelf",
      category: "Living",
      img: "https://i.pinimg.com/236x/6d/09/27/6d092743846c32104c157d602220efc2.jpg",
      price: "500",
      rating: "5.0",
      description: "A sleek and modern wall shelf, offering a stylish solution for displaying your decor and essentials."),


  ProductItem(
      id: 29,
      title: "Modern Bath Mirror",
      category: "Bath",
      img: "https://i.pinimg.com/236x/51/aa/04/51aa0491ad84a058c058955842fb1cd2.jpg",
      price: "200",
      rating: "3.6",
      description: "A sleek and modern mirror that enhances your bathroom decor."
  ),
  ProductItem(
      id: 30,
      title: "Luxury Towel Set",
      category: "Bath",
      img: "https://i.pinimg.com/236x/3e/75/eb/3e75eb95dc4642761bf05603828e3caf.jpg",
      price: "200",
      rating: "4.1",
      description: "Soft and absorbent luxury towels for a spa-like experience."
  ),
  ProductItem(
      id: 31,
      title: "Elegant Soap Dispenser",
      category: "Bath",
      img: "https://i.pinimg.com/236x/41/49/6b/41496b9207b46b4f1b5172e9f433293c.jpg",
      price: "250",
      rating: "3.9",
      description: "Stylish soap dispenser with a sleek and modern design."
  ),
  ProductItem(
      id: 32,
      title: "Minimalist Bathroom Shelf",
      category: "Bath",
      img: "https://i.pinimg.com/236x/29/06/91/29069153468d0251448e8b6ea6a5f518.jpg",
      price: "250",
      rating: "4.7",
      description: "A space-saving and elegant shelf for bathroom essentials."
  ),
  ProductItem(
      id: 33,
      title: "Wooden Bath Cabinet",
      category: "Bath",
      img: "https://i.pinimg.com/236x/0f/8b/e7/0f8be73566bab67966821b5c687edf09.jpg",
      price: "300",
      rating: "5.0",
      description: "Classic wooden bath cabinet for organized storage."
  ),
  ProductItem(
      id: 34,
      title: "Classic Bathroom Organizer",
      category: "Bath",
      img: "https://i.pinimg.com/236x/29/e5/c8/29e5c833612bdc10816d662bed38de04.jpg",
      price: "300",
      rating: "4.6",
      description: "Elegant organizer to keep your bathroom neat and tidy."
  ),
  ProductItem(
      id: 35,
      title: "Vintage Bathtub Caddy",
      category: "Bath",
      img: "https://i.pinimg.com/236x/8e/cb/8a/8ecb8a0b339e33a5727303c5b870b30c.jpg",
      price: "350",
      rating: "5.0",
      description: "A vintage-style bathtub caddy to hold bath essentials."
  ),
  ProductItem(
      id: 36,
      title: "Luxury Bath Mat",
      category: "Bath",
      img: "https://i.pinimg.com/236x/f2/29/44/f2294493d3cc6d6bc8860474a0baefd4.jpg",
      price: "350",
      rating: "4.2",
      description: "Soft and luxurious bath mat for added comfort."
  ),
  ProductItem(
      id: 37,
      title: "Stylish Bathroom Lights",
      category: "Bath",
      img: "https://i.pinimg.com/236x/4a/82/59/4a825972e8c5513b92a70d924818cc21.jpg",
      price: "400",
      rating: "3.8",
      description: "Modern bathroom lights to enhance your decor."
  ),
  ProductItem(
      id: 38,
      title: "Minimalist Shower Curtain",
      category: "Bath",
      img: "https://i.pinimg.com/474x/7b/ca/e9/7bcae9dd8b19352ab1621e18212b6bd3.jpg",
      price: "400",
      rating: "4.6",
      description: "Minimalist shower curtain with a clean and elegant look."
  ),
  ProductItem(
      id: 39,
      title: "Glass Soap Dish",
      category: "Bath",
      img: "https://i.pinimg.com/236x/de/e4/b0/dee4b073ce1ca22ad47cf5eb85f54a65.jpg",
      price: "450",
      rating: "4.6",
      description: "A sleek glass soap dish for modern bathrooms."
  ),
  ProductItem(
      id: 40,
      title: "Modern Bathroom Hooks",
      category: "Bath",
      img: "https://i.pinimg.com/736x/4f/13/4b/4f134b952e93639922969305ad8be04b.jpg",
      price: "450",
      rating: "4.2",
      description: "Stylish and functional hooks for your bathroom."
  ),
  ProductItem(
      id: 41,
      title: "Elegant Bathtub Tray",
      category: "Bath",
      img: "https://i.pinimg.com/236x/93/60/7b/93607bf1f9242b6674e17bb5ede14d4e.jpg",
      price: "500",
      rating: "4.3",
      description: "Elegant tray to hold essentials while you relax in the bath."
  ),
  ProductItem(
      id: 42,
      title: "Luxury Spa Set",
      category: "Bath",
      img: "https://i.pinimg.com/236x/57/d2/a2/57d2a2fc0317418635779868a80751cd.jpg",
      price: "500",
      rating: "5.0",
      description: "Complete spa set for a luxurious bathing experience."
  ),

// Kitchen Products
  ProductItem(
      id: 43,
      title: "Modern Kitchen Rack",
      category: "Kitchen",
      img: "https://i.pinimg.com/236x/58/06/21/5806212fbc7d21ce5ae935c0af4d612e.jpg",
      price: "150",
      rating: "4.5",
      description: "Space-saving kitchen rack for organizing utensils."
  ),
  ProductItem(
      id: 44,
      title: "Stainless Steel Knife Set",
      category: "Kitchen",
      img: "https://i.pinimg.com/236x/4d/13/62/4d1362fe203266229aeb26d553a3c9e6.jpg",
      price: "200",
      rating: "4.8",
      description: "High-quality stainless steel knife set for every kitchen."
  ),
  ProductItem(
      id: 45,
      title: "Wooden Cutting Board",
      category: "Kitchen",
      img: "https://i.pinimg.com/236x/71/8f/be/718fbefd27071a543eb495065ac1f68d.jpg",
      price: "180",
      rating: "4.6",
      description: "Durable wooden cutting board for all your chopping needs."
  ),
  ProductItem(
      id: 46,
      title: "Ceramic Spice Jar Set",
      category: "Kitchen",
      img: "https://i.pinimg.com/236x/7f/dc/ba/7fdcba2324e1ed1f5d59e7e64eff0b16.jpg",
      price: "220",
      rating: "4.4",
      description: "Elegant ceramic spice jars to store your spices."
  ),
  ProductItem(
      id: 47,
      title: "Minimalist Kitchen Shelf",
      category: "Kitchen",
      img: "https://i.pinimg.com/736x/9e/3b/fe/9e3bfe51537a7decb5c2a664841026ba.jpg",
      price: "250",
      rating: "4.7",
      description: "Minimalist shelf for stylish kitchen organization."
  ),
  ProductItem(
      id: 48,
      title: "Non-Stick Frying Pan",
      category: "Kitchen",
      img: "https://i.pinimg.com/236x/ad/f6/df/adf6dfe69a33009272246c41de78e0f5.jpg",
      price: "300",
      rating: "4.9",
      description: "Premium non-stick frying pan for easy cooking."
  ),
  ProductItem(
      id: 49,
      title: "Glass Storage Container",
      category: "Kitchen",
      img: "https://i.pinimg.com/236x/5b/22/d0/5b22d091856abf221288e85525722381.jpg",
      price: "180",
      rating: "4.5",
      description: "Airtight glass containers to keep your food fresh."
  ),
  ProductItem(
      id: 50,
      title: "Electric Kettle",
      category: "Kitchen",
      img: "https://i.pinimg.com/236x/9a/0f/33/9a0f332e428f7026eb34a2e404df93dc.jpg",
      price: "350",
      rating: "4.8",
      description: "Fast boiling electric kettle for tea and coffee."
  ),

  ProductItem(
      id: 51,
      title: "Modern Dining Table Set",
      category: "Dining",
      img: "https://i.pinimg.com/236x/ad/e4/43/ade443ae14734023905ab5a79da52878.jpg",
      price: "800",
      rating: "4.7",
      description: "Sleek and stylish dining table set for modern homes."
  ),
  ProductItem(
      id: 52,
      title: "Luxury Dinnerware Set",
      category: "Dining",
      img: "https://i.pinimg.com/474x/d4/b5/ac/d4b5ace8212beee732506931b6593d31.jpg",
      price: "300",
      rating: "4.9",
      description: "High-quality dinnerware set for elegant dining experiences."
  ),
  ProductItem(
      id: 53,
      title: "Elegant Wine Glasses",
      category: "Dining",
      img: "https://i.pinimg.com/236x/cc/76/5e/cc765e03421fdf00c31aa32baaa5b196.jpg",
      price: "250",
      rating: "4.6",
      description: "Crystal-clear wine glasses for a sophisticated touch."
  ),
  ProductItem(
      id: 54,
      title: "Wooden Serving Tray",
      category: "Dining",
      img: "https://i.pinimg.com/236x/29/e8/f3/29e8f35b8625c6289cf129432410b7dc.jpg",
      price: "180",
      rating: "4.4",
      description: "Handcrafted wooden serving tray for a rustic look."
  ),
  ProductItem(
      id: 55,
      title: "Minimalist Dining Chair",
      category: "Dining",
      img: "https://i.pinimg.com/236x/da/6b/be/da6bbe1998aee8b89bc1282761081075.jpg",
      price: "500",
      rating: "4.8",
      description: "Simple yet elegant dining chairs for a minimalist aesthetic."
  ),
  ProductItem(
      id: 56,
      title: "Classic Table Napkins",
      category: "Dining",
      img: "https://i.pinimg.com/236x/d1/e5/70/d1e570bba251482c4e97a7c36bc66bc6.jpg",
      price: "120",
      rating: "4.5",
      description: "Premium quality table napkins for a refined dining experience."
  ),
  ProductItem(
      id: 57,
      title: "Glass Pitcher with Lid",
      category: "Dining",
      img: "https://i.pinimg.com/236x/c8/64/a9/c864a97024a4b29939612c155cf7f208.jpg",
      price: "200",
      rating: "4.7",
      description: "Durable glass pitcher with a lid for serving beverages."
  ),
  ProductItem(
      id: 58,
      title: "Rustic Wooden Coasters",
      category: "Dining",
      img: "https://i.pinimg.com/474x/1a/a2/13/1aa21312d7311174fc0878f17d047c81.jpg",
      price: "150",
      rating: "4.6",
      description: "Eco-friendly wooden coasters for protecting your table."
  ),
  ProductItem(
      id: 59,
      title: "Luxury Cutlery Set",
      category: "Dining",
      img: "https://i.pinimg.com/236x/d1/67/af/d167af0e403d70c35fde14c53f4b8785.jpg",
      price: "350",
      rating: "4.9",
      description: "Premium stainless steel cutlery set for a luxurious dining experience."
  ),
  ProductItem(
      id: 60,
      title: "LED Table Lamp",
      category: "Dining",
      img: "https://i.pinimg.com/474x/41/cf/08/41cf08026f7e604b2ec731f4796c237c.jpg",
      price: "350",
      rating: "4.7",
      description: "Energy-efficient LED table lamp for ambient lighting."
  ),
  ProductItem(
      id: 61,
      title: "Marble Table Runner",
      category: "Dining",
      img: "https://i.pinimg.com/236x/46/94/43/469443ab17252fd934fe246c0378ff45.jpg",
      price: "300",
      rating: "4.6",
      description: "Elegant marble-patterned table runner for a chic look."
  ),
  ProductItem(
      id: 62,
      title: "Ceramic Salt & Pepper Shakers",
      category: "Dining",
      img: "https://i.pinimg.com/236x/28/9c/d7/289cd7a1b942a8e6e0ed4f1141a5e895.jpg",
      price: "150",
      rating: "4.5",
      description: "Stylish ceramic shakers for seasoning your meals."
  ),
  ProductItem(
      id: 63,
      title: "Vintage Candle Holder",
      category: "Dining",
      img: "https://i.pinimg.com/236x/7a/79/99/7a799983d4f9bb8951092aab7a82506a.jpg",
      price: "220",
      rating: "4.8",
      description: "Vintage-style candle holder for a cozy dining atmosphere."
  ),
  ProductItem(
      id: 64,
      title: "Decorative Fruit Bowl",
      category: "Dining",
      img: "https://i.pinimg.com/474x/ae/fc/05/aefc05139d912007a4528bd4ce08e5c0.jpg",
      price: "180",
      rating: "4.7",
      description: "Artistic fruit bowl to add a decorative touch to your dining table."
  ),

];



DROP DATABASE IF EXISTS hard4gamers;
CREATE DATABASE hard4gamers;
USE hard4gamers;
CREATE TABLE users(
  id INT(10) AUTO_INCREMENT NOT NULL,
  user_name VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL UNIQUE,
  password VARCHAR(60) NOT NULL,
  admin INT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY(id)
);
CREATE TABLE types(
  id INT(10) AUTO_INCREMENT NOT NULL,
  name VARCHAR(50) NOT NULL,
  PRIMARY KEY(id)
);
CREATE TABLE products(
  id INT(10) AUTO_INCREMENT NOT NULL,
  title VARCHAR(50) NOT NULL,
  type_id INT(10) NOT NULL,
  description TEXT NOT NULL,
  price DECIMAL NOT NULL,
  img VARCHAR(100) NOT NULL,
  deleted TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY(id),
  FOREIGN KEY (type_id) REFERENCES types (id)
);
CREATE TABLE orders(
  id INT(10) AUTO_INCREMENT NOT NULL,
  user_id INT(10) NOT NULL,
  total DECIMAL NOT NULL,
  createdAt DATE,
  updatedAt DATE,
  PRIMARY KEY(id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);
CREATE TABLE carts(
  id INT(10) AUTO_INCREMENT NOT NULL,
  user_id INT(10) NOT NULL,
  product_id INT(10) NOT NULL,
  quantity INT(6) NOT NULL,
  sub_total DECIMAL NOT NULL,
  order_id INT(10) NULL,
  PRIMARY KEY(id),
  FOREIGN KEY (product_id) REFERENCES products (id),
  FOREIGN KEY (order_id) REFERENCES orders (id),
  FOREIGN KEY (user_id) REFERENCES users (id)
);
INSERT INTO
  users
VALUES(
    DEFAULT,
    "Toto Fabrizio",
    "tomas.fabrizio02@gmail.com",
    "$2a$10$Dg4juHqOZihiPlDd6aUlQuH.LLuQCFYYvMZJQ0sqJmCEzWDcc9cVu",
    1
  ),
  (
    DEFAULT,
    "Juan Bordignon",
    "juanibordil@gmail.com",
    "$2a$10$otJjZB4dcgnt6.G0EAEXeuZJqoMuTlMXUFeRuJnV.wvM3vAyL22bm",
    1
  ),
  (
    DEFAULT,
    'Pablo Perez',
    'qwe@qwe.com',
    '$2a$10$HWGehePpXekQ9jp2hvyw1eNnE7FMPvRQHpLjGVZYtLyom0xklNnDa',
    0
  );
INSERT INTO
  types
VALUES(DEFAULT, "Placa madre"),
  (DEFAULT, "Procesador"),
  (DEFAULT, "Ram"),
  (DEFAULT, "SSD"),
  (DEFAULT, "HDD"),
  (DEFAULT, "Tarjeta gráfica"),
  (DEFAULT, "Parlantes"),
  (DEFAULT, "Teclado"),
  (DEFAULT, "Mouse"),
  (DEFAULT, "Monitor"),
  (DEFAULT, "Auriculares");
INSERT INTO
  products
VALUES(
    DEFAULT,
    "Ryzen 5 3600",
    2,
    "Clave en el rendimiento de tu computadora de escritorio, ya no tenés que pensar en cómo distribuir el tiempo y acciones porque ahora las tareas en simultáneo son posibles. AMD cuenta con un catálogo de productos que se adaptan a los requerimientos de todo tipo de usuarios: juegos en línea, edición a gran escala, contenido en múltiples plataformas y más.",
    37999,
    "/images/Ryzen5-3600.jpg",
    0
  ),
  (
    DEFAULT,
    "MSI GeForce RTX 3060 Ti",
    6,
    "Nvidia es el fabricante líder de placas de video; su calidad asegura una experiencia positiva en el desarrollo del motor gráfico de tu computadora. Además, sus procesadores usan tecnología de punta para que puedas disfrutar de un producto veloz y duradero. Velocidad en cada lectura, cuenta con 4864 núcleos, por lo que la interfaz de la placa será algo sorprendente. Este tipo de estructura es apropiado para el procesamiento de tecnologías más complejas y modernas caracterizadas por grandes volúmenes de datos. Calidad de imagen, criterio fundamental a la hora de elegir una placa de video, su resolución de 7680x4320 no te defraudará. La decodificación de los píxeles en tu pantalla te harán ver hasta los detalles más ínfimos en cada ilustración.",
    204000,
    "/images/MSI-Ventus-GeForce-RTX-3060-Ti.jpg",
    0
  ),
  (
    DEFAULT,
    "Samsung F24T35",
    10,
    "Este monitor led de 24 pulgadas te va a resultar cómodo para estudiar, trabajar o ver una película en tus tiempos de ocio. Asimismo, su resolución de 1920 x 1080 te permite disfrutar de momentos únicos gracias a una imagen de alta fidelidad. Su tiempo de respuesta de 5 ms lo hace ideal para gamers y cinéfilos porque es capaz de mostrar imágenes en movimiento sin halos o bordes borrosos.",
    25999,
    "/images/Samsung-F24T35-led-24.jpg",
    0
  ),
  (
    DEFAULT,
    "Redragon Kumara K552",
    8,
    "La gran calidad del Redragon Kumara K552, y su precio económico lo vuelven un atractivo ideal para que te diviertas frente a la pantalla. Su ergonomía, su base antidelizante y su rápido tiempo de respuesta permite que tus juegos favoritos se sientan más cerca que nunca, al alcance de tus manos.",
    6439,
    "/images/Redragon-Kumara-K552.jpg",
    0
  ),
  (
    DEFAULT,
    "HAVIT GAMER 4BOT MS-72BL",
    9,
    "Mouse gamer. Sensor: Optico. Resolucion: 1200 DPI.",
    579,
    "/images/HAVIT-GAMER-4BOT-MS-72BL.jpg",
    0
  ),
  (
    DEFAULT,
    "Wesdar X10 Gris",
    9,
    "Mouse Gaming , 2400 Dpi , 6 Botones inteligentes.",
    2285,
    "/images/Wesdar-X10-Gris.jpg",
    0
  ),
  (
    DEFAULT,
    "Kotion G9000",
    11,
    "¡Experimentá la adrenalina de sumergirte en la escena de otra manera! Tener auriculares específicos para jugar cambia completamente tu experiencia en cada partida. Con los Kotion Each G9000 no te perdés ningún detalle y escuchás el audio tal y como fue diseñado por los creadores. El formato perfecto para vos, al ser headset vas a poder escuchar tu música preferida, mantener llamadas telefónicas y jugar en línea desde tu pc sin perderte ningún detalle.",
    2599,
    "/images/Kotion-G9000.jpg",
    0
  ),
  (
    DEFAULT,
    "Redragon Themis H220n",
    11,
    "Un auricular con un sonido brillante y claro, con una estructura liviana y cómoda, el Themis es un auricular pensado para jugar cómodamente.",
    2279,
    "/images/Redragon-Themis-H220n.jpg",
    0
  ),
  (
    DEFAULT,
    "Redragon Hylas H260",
    11,
    "¡Experimentá la adrenalina de sumergirte en la escena de otra manera! Tener auriculares específicos para jugar cambia completamente tu experiencia en cada partida. Con los Kotion Each G9000 no te perdés ningún detalle y escuchás el audio tal y como fue diseñado por los creadores. El formato perfecto para vos, al ser headset vas a poder escuchar tu música preferida, mantener llamadas telefónicas y jugar en línea desde tu pc sin perderte ningún detalle.",
    2469,
    "/images/Redragon-Hylas-H260.jpg",
    0
  );
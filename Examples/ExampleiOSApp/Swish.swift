let swish = Swish(scripts: [
  "bootstrap": Swift(path: "swish-scripts", target: "bootstrap", arguments: "."),
  "appstore": Swift(path: "swish-scripts", target: "appstore", arguments: "."),
])
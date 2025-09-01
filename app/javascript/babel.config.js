module.exports = function (api) {
  api.cache(true);

  const presets = [
    ['@babel/preset-env', { targets: "defaults" }]
  ];

  const plugins = [
    '@babel/plugin-proposal-class-properties',
    '@babel/plugin-proposal-object-rest-spread',
    '@babel/plugin-proposal-private-methods'
  ];

  return { presets, plugins };
};

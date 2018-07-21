# cush-plugin-nebu v0.1.0

An alternative to [Babel][1] for plugins that transform Javascript.

### [Learn more][2]

[1]: https://github.com/babel/babel
[2]: https://github.com/aleclarson/nebu

## Configuration

Each package can have its own `nebu.config.js` module that customizes its plugins and other options.

Your `cush.config.js` module can configure the `nebu.plugins` property too, but it needs to be in a worker first.

```js
this.worker(function() {
  this.merge('nebu.plugins', [
    // nebu plugins go here
  ]);
});
```

The `"nebu"` hook provides access to the state of each asset after its plugins are used.

```js
// cush.config.js
this.worker(function() {
  this.hook('nebu', (asset, state) => {
    // The state is unique to each asset and updated by nebu plugins.
  });
});
```

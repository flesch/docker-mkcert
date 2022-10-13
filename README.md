# flesch/mkcert

Yet another dockerized [mkcert](https://github.com/FiloSottile/mkcert) (though [it's been done before](https://hub.docker.com/search?q=mkcert&type=image&sort=updated_at&order=desc)).

Generate a certificate:

```shell
docker run -it --rm \
  --volume "${PWD}:/.local/share/mkcert" \
  flesch/mkcert "*.example.com"
```

<details>
<summary>More Examples</summary>

```shell
docker run -it --rm \
  --volume "${PWD}:/.local/share/mkcert" \
  flesch/mkcert -key-file "example-key.pem" \
  -cert-file "example.pem" "*.example.com"
```
</details>

As `mkcert` runs inside a container, the local CA won't be installed on the host machine. `mkcert -install` will only create `rootCA.pem` — you will need to install it manually. 

On macOS, you can manually install `rootCA.pem` like so:

```shell
sudo security add-trusted-cert -d -r trustRoot \
  -k /Library/Keychains/System.keychain ${PWD}/rootCA.pem
```

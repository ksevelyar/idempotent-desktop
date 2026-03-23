# DNS

```fish
for d in google.com youtube.com facebook.com instagram.com x.com amazon.com apple.com microsoft.com netflix.com wikipedia.org reddit.com github.com nytimes.com bbc.com cnn.com alibaba.com tiktok.com zoom.us paypal.com whatsapp.com
    echo -n "$d: "
    dig +nocmd +noall +stats $d 2>/dev/null | grep -o 'Query time: .*'
end
```

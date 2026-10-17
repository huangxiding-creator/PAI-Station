# Go-Cloudscraper

[![Go Report Card](https://goreportcard.com/badge/github.com/Advik-B/cloudscraper)](https://goreportcard.com/report/github.com/Advik-B/cloudscraper)
[![Go.Dev reference](https://img.shields.io/badge/go.dev-reference-blue?logo=go&logoColor=white)](https://pkg.go.dev/github.com/Advik-B/cloudscraper/lib)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A comprehensive, standalone Go port of the popular Python [`cloudscraper`](https://github.com/VeNoMouS/cloudscraper) library, designed to bypass Cloudflare's anti-bot protection.

This library is written in pure Go and aims to have **no external runtime dependencies like Node.js** by default. It simulates a browser environment internally to solve even modern JavaScript challenges, making your compiled Go application truly portable and self-contained. For advanced use cases, it also supports offloading JS execution to external runtimes like Node.js, Deno, or Bun.

## Features

This library aims for feature-parity with the original Python version, providing a robust and production-ready solution for Go applications.

| Feature | Status | Description |
| :--- | :--- | :--- |
| **Standalone Binary** | ✅ **Complete** | Uses `go:embed` and a pure Go JS interpreter (`otto`) by default. No Node.js required. |
| **External JS Runtimes**| ✅ **Complete** | Supports offloading JS execution to **Node.js, Deno, or Bun** for maximum compatibility. |
| **Session & Cookie Handling** | ✅ **Complete** | Automatically manages a `cookiejar` to handle Cloudflare's session cookies. |
| **JS Challenge Solver (v1)** | ✅ **Complete** | Solves the classic JavaScript math-based challenges internally. |
| **JS Challenge Solver (v2/v3)** | ✅ **Complete** | Simulates a browser DOM within Go to solve modern JS VM challenges. |
| **Stealth Mode** | ✅ **Complete** | Applies human-like delays, header randomization, and browser-specific quirks. |
| **Proxy Management** | ✅ **Complete** | Includes a thread-safe proxy manager with sequential, random, and smart rotation. |
| **403 Forbidden Recovery** | ✅ **Complete** | Automatically detects and recovers from `403` errors by refreshing the session. |
| **Captcha Solver Framework** | ✅ **Extensible** | Provides a `Solver` interface and a working `2captcha` implementation. |
| **Detailed Configuration** | ✅ **Complete** | Uses an idiomatic functional options pattern for easy and detailed configuration. |

## Installation

To get the latest version of the library, use `go get`:
```bash
go get github.com/Advik-B/cloudscraper/lib
```

## Basic Usage

Here is the simplest way to use this, is to make a GET request to a protected site.

```go
package main

import (
	"fmt"
	"io"
	"log"
        "github.com/Advik-B/cloudscraper/lib"
)

func main() {
	// Create a new scraper with default settings
	sc, err := cloudscraper.New()
	if err != nil {
		log.Fatalf("Failed to create scraper: %v", err)
	}

	// Make a GET request
	resp, err := sc.Get("https://nowsecure.nl") // A site known to be protected by Cloudflare
	if err != nil {
		log.Fatalf("Request failed: %v", err)
	}
	defer resp.Body.Close()

	fmt.Printf("Status: %s\n", resp.Status)

	// Read and print the body
	body, err := io.ReadAll(resp.Body)
	if err != nil {
		log.Fatalf("Failed to read response body: %v", err)
	}
	
	// Print a preview of the response
	preview := string(body)
	if len(preview) > 500 {
		preview = preview[:500]
	}
	fmt.Printf("Body Preview:\n%s...\n", preview)
}
```

## Advanced Configuration

`go-cloudscraper` uses a functional options pattern for configuration, allowing you to easily customize its behavior.

### Using External JavaScript Runtimes

By default, `go-cloudscraper` uses a built-in Go-based JavaScript interpreter (`otto`) for maximum portability. However, for the most complex or future Cloudflare challenges, you may get better results by using an external, full-featured JavaScript runtime like Node.js, Deno, or Bun.

To use an external runtime, it must be installed and available in your system's `PATH`.

```go
import (
        "github.com/Advik-B/cloudscraper/lib"
	"github.com/Advik-B/cloudscraper/lib/js"
)

sc, err := cloudscraper.New(
    // Use type-safe constants for the runtime.
    // Can be js.Node, js.Deno, or js.Bun.
    cloudscraper.WithJSRuntime(js.Node),
)
```

### Using Proxies

Provide a slice of proxy URLs. The manager supports `Sequential` and `Random` rotation.

```go
import (
    "time"
    "github.com/Advik-B/cloudscraper/lib"
    "github.com/Advik-B/cloudscraper/lib/proxy"
)

proxies := []string{
    "http://user:pass@proxy1.com:8080",
    "http://user:pass@proxy2.com:8080",
}

sc, err := cloudscraper.New(
    cloudscraper.WithProxies(proxies, proxy.Random, 5*time.Minute),
)
```

### Using a Captcha Solver

If a site presents a reCaptcha or Turnstile challenge, you can configure a solver.

```go
import (
    "github.com/Advik-B/cloudscraper/lib"
    "github.com/Advik-B/cloudscraper/lib/captcha"
)

// Initialize your chosen captcha solver
solver := captcha.NewTwoCaptchaSolver("YOUR_2CAPTCHA_API_KEY")

sc, err := cloudscraper.New(
    cloudscraper.WithCaptchaSolver(solver),
)
```

### Customizing Browser and Stealth Mode

You can change the browser identity and tweak stealth options to better suit your target.

```go
import (
    "time"
    "github.com/Advik-B/cloudscraper/lib"
    "github.com/Advik-B/cloudscraper/lib/stealth"
    useragent "github.com/Advik-B/cloudscraper/lib/user_agent"
)

sc, err := cloudscraper.New(
    // Pretend to be Firefox on Linux
    cloudscraper.WithBrowser(useragent.Config{
        Browser:  "firefox",
        Platform: "linux",
        Desktop:  true,
    }),
    // Configure stealth delays
    cloudscraper.WithStealth(stealth.Options{
        Enabled:         true,
        MinDelay:        1 * time.Second,
        MaxDelay:        5 * time.Second,
        HumanLikeDelays: true,
    }),
)
```

### Full Configuration Example

Here’s how you can combine multiple options to create a highly customized scraper instance.

```go
package main

import (
	"fmt"
	"log"
	"time"

	"github.com/Advik-B/cloudscraper/lib"
	"github.com/Advik-B/cloudscraper/lib/js"
	"github.com/Advik-B/cloudscraper/lib/proxy"
	"github.com/Advik-B/cloudscraper/lib/stealth"
	useragent "github.com/Advik-B/cloudscraper/lib/user_agent"
)

func main() {
	var scraperOptions []cloudscraper.ScraperOption

	// Use an external JS runtime for better challenge compatibility
	scraperOptions = append(scraperOptions, cloudscraper.WithJSRuntime(js.Node))

	// Add proxies with random rotation
	scraperOptions = append(scraperOptions, cloudscraper.WithProxies(
		[]string{"http://user:pass@proxy1:8080", "http://user:pass@proxy2:8080"},
		proxy.Random,
		5*time.Minute,
	))

	// Customize the browser to appear as Chrome on Windows
	scraperOptions = append(scraperOptions, cloudscraper.WithBrowser(useragent.Config{
		Browser:  "chrome",
		Platform: "windows",
	}))

	// Customize session handling
	scraperOptions = append(scraperOptions, cloudscraper.WithSessionConfig(
		true,           // Auto-refresh on 403s
		30*time.Minute, // Refresh session every 30 mins
		5,              // Max 403 retries
	))

	// Create the scraper with all our options
	sc, err := cloudscraper.New(scraperOptions...)
	if err != nil {
		log.Fatalf("Failed to create scraper: %v", err)
	}

	// Use the scraper...
	resp, err := sc.Get("https://nowsecure.nl")
	if err != nil {
		log.Fatal(err)
	}
	defer resp.Body.Close()

	fmt.Println("Success:", resp.Status)
}
```

## How It Works

This library mimics the interaction flow a real browser would have with a Cloudflare-protected site:

1.  **Initial Request:** An initial request is made to the target URL.
2.  **Challenge Detection:** The scraper checks the response. If it receives a `503 Service Unavailable` or `403 Forbidden` with the tell-tale Cloudflare headers and body, it identifies a challenge.
3.  **Challenge Analysis:** It parses the HTML to determine the type of challenge:
    *   **v1 JavaScript Challenge:** A math-based problem obfuscated in JS.
    *   **v2/v3 JavaScript Challenge:** A more complex script that expects a browser-like environment.
    *   **reCaptcha/Turnstile:** Requires a CAPTCHA token.
4.  **Solving:**
    *   For **v1 and v2/v3 challenges**, it uses the configured **JavaScript Engine** (either the built-in `otto` or an external runtime like `node`) with a simulated DOM environment to execute the scripts and compute the correct answer.
    *   For **Captcha challenges**, it delegates the site-key to the configured `CaptchaSolver` to get a token.
5.  **Submission & Cookie Handling:** The solved answer or token is submitted back to Cloudflare. If successful, Cloudflare returns a `cf_clearance` cookie. The scraper's internal `cookiejar` stores this cookie for subsequent requests to the site.
6.  **Success:** The original request is retried, now with the clearance cookie, and should succeed.

## Versioning Convention

Tags in this project follow a structured naming format:

```
v<library-version>-pyv<cloudscraper-python-version>
```

* `v<library-version>` refers to the version of this Go library.
* `pyv<cloudscraper-python-version>` indicates the version of the original Python `cloudscraper` project that was ported or matched in functionality.

For example:

```
v1.0-pyv3.0.0
```

This means:

* The Go port is at version **1.0**.
* It mirrors features and behavior from the Python `cloudscraper` version **3.0.0**.

This dual-tag system helps developers easily identify compatibility with the original Python package.

## Contributing

Contributions are welcome! If you find a bug, have a feature request, or want to improve the library, please feel free to open an issue or submit a pull request.

## License

This project is licensed under the MIT License.

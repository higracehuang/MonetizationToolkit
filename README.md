# MonetizationToolkit

A toolkit for monetizing your app, including:

- Paywall prompt manager to manage show and hide of paywall based on version history

## Examples

### Using PaywallPromptManager to control when to show the paywall

```Swift
import MonetizationToolkit

struct ContentView: View {
    @State var displayPaywall: Bool = false
    @AppStorage("hasIAP") var hasIAP: Bool = false
    
    var body: some View {
        Text("Hello, World!")
    }.purchaseIAPSheet(displayPaywall: $displayPaywall)
    .onAppear {
        displayPaywall = PaywallPromptManager.shared.shouldPromptForPaywall(hasIAP: hasIAP)
    }
}
```

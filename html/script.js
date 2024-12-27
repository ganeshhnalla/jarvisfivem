window.addEventListener('message', function(event) {
    if (event.data.action == 'speak') {
        let text = event.data.text;
        let speech = new SpeechSynthesisUtterance(text);
        speech.lang = 'en-US';
        
        // Use voice settings if needed
        window.speechSynthesis.speak(speech);
    }
});

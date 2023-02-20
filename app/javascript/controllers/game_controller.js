import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  stream = null;
  connect() {
    document.getElementById("start-sse").disabled = false
    document.getElementById("start-sse").classList.remove('translate-y-0.5', 'bg-blue-700')
    document.getElementById("start-sse").addEventListener("click", (e) => {
      e.preventDefault();
      document.getElementById("start-sse").disabled = true;
      document.getElementById("start-sse").classList.add('translate-y-0.5', 'bg-blue-700')
      this.stream = new EventSource("/sse");
      this.stream.addEventListener("update-event", (event) => {
        const { matrix } = JSON.parse(event.data);
        document.getElementById("table").innerHTML = matrix;
      });
    });
    document.getElementById("stop-sse").addEventListener("click", (e) => {
      e.preventDefault();
      document.getElementById("start-sse").disabled = false;
      document.getElementById("start-sse").classList.remove('translate-y-0.5', 'bg-blue-700')
      this.stream.close();
    });
  }
  disconnect() {
    this.stream && this.stream.close();
  }
}

const tracks = [
  {
    name: "HTML",
    icon: "</>",
    progress: 72,
    color: "#00E676",
    levels: [
      ["Level 1", "Beginner", true],
      ["Level 2", "Intermediate", true],
      ["Level 3", "Advanced", false],
    ],
    lesson: "Build Your First Pixel Card",
    challenge: "Make the button text say START.",
  },
  {
    name: "Java",
    icon: "JV",
    progress: 36,
    color: "#00B0FF",
    levels: [
      ["Level 1", "Beginner", true],
      ["Level 2", "Intermediate", false],
      ["Level 3", "Advanced", false],
    ],
    lesson: "Unlock Loops and Conditions",
    challenge: "Which keyword repeats while a condition is true?",
  },
  {
    name: "Python",
    icon: "PY",
    progress: 54,
    color: "#FFD166",
    levels: [
      ["Level 1", "Beginner", true],
      ["Level 2", "Intermediate", true],
      ["Level 3", "Advanced", false],
    ],
    lesson: "Debug the Potion Function",
    challenge: "Which Python keyword defines a function?",
  },
];

const tracksRoot = document.querySelector("#tracks");
const lessonTrack = document.querySelector("#lessonTrack");
const lessonTitle = document.querySelector("#lessonTitle");
const challengeText = document.querySelector("#challengeText");
const answerInput = document.querySelector("#answerInput");
const feedbackModal = document.querySelector("#feedbackModal");
const feedbackTitle = document.querySelector("#feedbackTitle");
const feedbackMessage = document.querySelector("#feedbackMessage");
const codeEditor = document.querySelector("#codeEditor");
const preview = document.querySelector("#preview");

function renderTracks() {
  tracksRoot.innerHTML = tracks
    .map(
      (track, index) => `
        <article class="track-card" style="--accent: ${track.color}">
          <div class="track-top">
            <div>
              <p class="eyebrow">${track.name} Path</p>
              <h3>${track.name}</h3>
            </div>
            <span class="track-icon">${track.icon}</span>
          </div>
          <div class="progress" aria-label="${track.name} progress">
            <span style="width: ${track.progress}%"></span>
          </div>
          <div class="levels">
            ${track.levels
              .map(
                ([label, title, unlocked]) => `
                  <div class="level-row ${unlocked ? "unlocked" : ""}">
                    <span>${label}</span>
                    <span>${unlocked ? title : "LOCKED"}</span>
                  </div>
                `
              )
              .join("")}
          </div>
          <button class="pixel-button start-track" data-index="${index}" type="button">START</button>
        </article>
      `
    )
    .join("");
}

function showFeedback(success, message) {
  feedbackTitle.textContent = success ? "QUEST CLEAR!" : "GAME OVER";
  feedbackTitle.style.color = success ? "var(--accent)" : "var(--danger)";
  feedbackMessage.textContent = message;
  feedbackModal.classList.remove("hidden");
}

function runPreview() {
  const css = `
    <style>
      body { font-family: monospace; padding: 20px; background: #f8f8f8; }
      .card { border: 4px solid #111; padding: 18px; box-shadow: 6px 6px 0 #00e676; }
      button { border: 3px solid #111; padding: 10px 16px; background: #00b0ff; font-weight: 700; }
    </style>
  `;
  preview.srcdoc = `${css}${codeEditor.value}`;
}

renderTracks();
runPreview();

tracksRoot.addEventListener("click", (event) => {
  const button = event.target.closest(".start-track");
  if (!button) return;
  const track = tracks[Number(button.dataset.index)];
  lessonTrack.textContent = `${track.name} Quest 1`;
  lessonTitle.textContent = track.lesson;
  challengeText.textContent = track.challenge;
  answerInput.value = "";
  document.querySelector("#lesson").scrollIntoView({ behavior: "smooth" });
});

document.querySelector("#runCode").addEventListener("click", runPreview);

document.querySelector("#checkAnswer").addEventListener("click", () => {
  const answer = answerInput.value.trim().toLowerCase();
  const challenge = challengeText.textContent.toLowerCase();
  const correct =
    (challenge.includes("start") && answer === "start") ||
    (challenge.includes("while") && answer === "while") ||
    (challenge.includes("function") && answer === "def");

  if (correct) {
    showFeedback(true, "XP gained. Next node unlocked and your streak is safe.");
    return;
  }

  showFeedback(false, "Try again. Hint: read the quest text and look for the exact coding keyword.");
});

document.querySelector("#closeFeedback").addEventListener("click", () => {
  feedbackModal.classList.add("hidden");
});

document.querySelector("#themeToggle").addEventListener("click", (event) => {
  document.documentElement.classList.toggle("light");
  event.currentTarget.textContent = document.documentElement.classList.contains("light")
    ? "DARK"
    : "LIGHT";
});

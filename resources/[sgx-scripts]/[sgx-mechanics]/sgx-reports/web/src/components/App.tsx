import React, { useState, useEffect  } from "react";
import "./App.css";
import { debugData } from "../utils/debugData";
import { useNuiEvent } from "../hooks/useNuiEvent";
import { fetchNui } from "../utils/fetchNui";

debugData([
  {
    action: "setVisible",
    data: true,
  },
]);

const App: React.FC = () => {
  const [Title, setTitle] = useState("");
  const [Description, setDescription] = useState("");
  const [URL, setURL] = useState("");
  const texts = ['General Stuff', 'Lost Item or Reward', '3D Models or Clothing', 'Exploit'];
  const [currentIndex, setCurrentIndex] = useState(0);
  const [currentReportType, setCurrentReportType] = useState(texts[currentIndex]);

  useEffect(() => {
    setCurrentReportType(texts[currentIndex]);
  }, [currentIndex]);

  useNuiEvent("setVisible", (data: any) => {
    console.log("setVisible", data);
  });

  const handleRightClick = () => {
    setCurrentIndex((currentIndex + 1) % texts.length);
  };

  const handleLeftClick = () => {
    setCurrentIndex((currentIndex - 1 + texts.length) % texts.length);
  };

  const handleSubmit = () => {
    fetchNui<any>("submitdata", {
      title: Title,
      description: Description,
      url: URL,
      type: currentReportType
    }).catch((e) => {
      console.error(`Error submitting data:`, e);
    });
  
    setTitle("");
    setDescription("");
    setURL("");
  };
  
  

  return (
    <div id="root">
      <div className="_App_yyqr0_1">
        <div className="_container_yyqr0_11">
          <div className="_border_yyqr0_24">
            <div className="_header_sj086_1">
              <svg
                width="4.53vh"
                height="4.53vh"
                viewBox="0 0 49 49"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  fillRule="evenodd"
                  clipRule="evenodd"
                  d="M21.87 14.0385C21.7073 14.1032 21.5435 14.2835 21.4996 14.4463C21.4507 14.6281 21.4943 14.783 21.7625 15.3794C21.8668 15.6114 21.9521 15.818 21.9521 15.8385C21.9521 15.8591 21.8458 15.9065 21.7159 15.944C21.3191 16.0585 21.0073 16.2511 20.6536 16.6003C20.3889 16.8615 20.2854 17.0007 20.1496 17.2781C19.9185 17.75 19.8584 18.0687 19.8576 18.8285L19.8569 19.4548H24.4993H29.1417L29.141 18.8285C29.1401 18.0687 29.0801 17.75 28.8489 17.2781C28.5482 16.6639 27.9184 16.1275 27.2827 15.944C27.1527 15.9065 27.0464 15.8591 27.0464 15.8385C27.0464 15.818 27.1318 15.6114 27.2361 15.3794C27.5062 14.7786 27.548 14.6287 27.4977 14.4418C27.4139 14.1308 27.0456 13.9321 26.7399 14.033C26.5244 14.1041 26.4183 14.2647 26.0742 15.0407C25.9042 15.4242 25.746 15.7611 25.7228 15.7893C25.6908 15.8282 25.3937 15.8406 24.4952 15.8406C23.3104 15.8406 23.3097 15.8406 23.2519 15.7482C23.2201 15.6974 23.0687 15.3693 22.9155 15.0192C22.7623 14.6691 22.5914 14.3206 22.5356 14.2448C22.3756 14.0272 22.1075 13.9441 21.87 14.0385ZM15.2966 18.3302C15.0503 18.4845 15.0307 18.5534 15.0168 19.313C15.0064 19.8808 15.019 20.0865 15.0834 20.4017C15.3803 21.8545 16.4881 23.016 17.9119 23.3674L18.2546 23.4519V24.0818V24.7117L16.3751 24.7126C14.6298 24.7135 14.4835 24.719 14.3268 24.7901C14.003 24.9371 13.8978 25.3651 14.1116 25.6653C14.2675 25.8842 14.2364 25.8808 16.3032 25.9028L18.2341 25.9233V26.5557V27.1882L17.9112 27.2643C17.2759 27.4142 16.6166 27.7895 16.1246 28.2814C15.6457 28.7601 15.3598 29.2514 15.1459 29.963C15.0526 30.2735 15.0368 30.4134 15.0193 31.0828C14.9969 31.9451 15.0227 32.0893 15.2281 32.2451C15.5004 32.4516 15.8965 32.3988 16.088 32.1305C16.1724 32.0123 16.1822 31.9391 16.2068 31.2419C16.2365 30.4026 16.2748 30.2202 16.521 29.7428C16.6923 29.4108 17.1759 28.8981 17.4897 28.7158C17.7279 28.5774 18.194 28.4022 18.2296 28.4377C18.2433 28.4515 18.255 28.6584 18.2553 28.8975C18.2596 31.4469 20.026 33.8494 22.5002 34.6708C25.3831 35.6279 28.4493 34.4466 29.9598 31.7966C30.4506 30.9356 30.7416 29.8587 30.7432 28.8975C30.7436 28.6584 30.7552 28.4515 30.769 28.4377C30.8045 28.4022 31.2706 28.5774 31.5089 28.7158C31.8227 28.8981 32.3063 29.4108 32.4775 29.7428C32.7238 30.2202 32.762 30.4026 32.7917 31.2419C32.8164 31.9391 32.8262 32.0123 32.9105 32.1305C33.102 32.3988 33.4982 32.4516 33.7705 32.2451C33.9758 32.0893 34.0017 31.9451 33.9792 31.0828C33.9617 30.4134 33.9459 30.2735 33.8526 29.963C33.6388 29.2514 33.3529 28.7601 32.874 28.2814C32.3819 27.7895 31.7226 27.4142 31.0874 27.2643L30.7645 27.1882V26.5557V25.9233L32.6954 25.9028C34.7621 25.8808 34.731 25.8842 34.8869 25.6653C35.1014 25.3643 35.0003 24.955 34.6724 24.7963C34.5038 24.7147 34.4319 24.7117 32.6208 24.7117H30.7439V24.0818V23.4519L31.0867 23.3674C32.5105 23.016 33.6183 21.8545 33.9152 20.4017C33.9796 20.0865 33.9921 19.8808 33.9818 19.313C33.9703 18.6885 33.9601 18.601 33.8868 18.5034C33.636 18.1692 33.1225 18.1867 32.8927 18.5372C32.8314 18.6307 32.8138 18.7781 32.7906 19.3913C32.7741 19.8291 32.7385 20.2165 32.7035 20.3378C32.5053 21.0257 32.0936 21.5586 31.4804 21.9211C31.2809 22.0391 30.8693 22.2065 30.7785 22.2065C30.7595 22.2065 30.7437 22.0355 30.7435 21.8266C30.7429 21.2427 30.5649 20.937 30.1165 20.7498C29.9871 20.6957 29.6254 20.6869 27.5414 20.6869H25.1168L25.1059 24.3186C25.0951 27.914 25.0941 27.9514 25.0103 28.0637C24.8585 28.2669 24.7148 28.3464 24.4993 28.3464C24.2838 28.3464 24.1401 28.2669 23.9883 28.0637C23.9044 27.9514 23.9034 27.914 23.8926 24.3186L23.8817 20.6869H21.4571C19.3731 20.6869 19.0114 20.6957 18.8821 20.7498C18.4336 20.937 18.2557 21.2427 18.255 21.8266C18.2548 22.0355 18.239 22.2065 18.22 22.2065C18.2009 22.2065 18.0854 22.1719 17.9632 22.1296C17.3174 21.9061 16.709 21.3507 16.4416 20.7402C16.2737 20.3569 16.2361 20.1403 16.2079 19.3913C16.1771 18.5753 16.1548 18.4991 15.9004 18.3441C15.7407 18.2467 15.4409 18.2399 15.2966 18.3302Z"
                  fill="#00F8B9"
                />
                <path
                  d="M22.75 1.58771C23.8329 0.962498 25.1671 0.962498 26.25 1.58771L43.4676 11.5283C44.5505 12.1535 45.2176 13.309 45.2176 14.5594V34.4406C45.2176 35.691 44.5505 36.8465 43.4676 37.4717L26.25 47.4123C25.1671 48.0375 23.8329 48.0375 22.75 47.4123L5.53238 37.4717C4.44947 36.8465 3.78238 35.691 3.78238 34.4406V14.5594C3.78238 13.309 4.44947 12.1535 5.53238 11.5283L22.75 1.58771Z"
                  fill="url(#paint0_radial_5027_543)"
                  fillOpacity="0.25"
                  stroke="url(#paint1_radial_5027_543)"
                />
                <defs>
                  <radialGradient
                    id="paint0_radial_5027_543"
                    cx={0}
                    cy={0}
                    r={1}
                    gradientUnits="userSpaceOnUse"
                    gradientTransform="translate(24.5 24.5) rotate(48.6215) scale(30.4743)"
                  >
                    <stop stopColor="#00F8B9" />
                    <stop offset={1} stopColor="#00664C" />
                  </radialGradient>
                  <radialGradient
                    id="paint1_radial_5027_543"
                    cx={0}
                    cy={0}
                    r={1}
                    gradientUnits="userSpaceOnUse"
                    gradientTransform="translate(24.5 24.5) rotate(73.393) scale(36.4322)"
                  >
                    <stop stopColor="#00F8B9" />
                    <stop offset={1} stopColor="#00F8B9" stopOpacity="0.39" />
                  </radialGradient>
                </defs>
              </svg>
              <div className="flex flex-col justify-start items-start">
                <div className="_title_sj086_9">BUG REPORT</div>
                <div className="_description_sj086_18">
                  PLEASE FILL OUT THE FORM BELOW TO REPORT A BUG.
                </div>
              </div>
              <div className="_keybind_sj086_26">
                <div className="_text_sj086_43">Exit</div>
                <div className="_button_sj086_46">ESC</div>
              </div>
            </div>
            <div className="_info_1c0w4_1">
              <div className="_description_1c0w4_13">
                <p>
                  Be descriptive, succinct, and provide enough information that
                  someone can reproduce and verify your issue.
                </p>
                <p>The report will be uploaded to the forums @ nopixel.net</p>
                <p>
                  We reserve the right to close your ticket with no reply if its
                  total dogshit.
                </p>
                <p>
                  Select a report type before submitting, please pick the
                  category that is the best fit.
                </p>
              </div>
              <div className="_divider_1c0w4_29" />
            </div>
            <div className="_type_1ebau_1">
              <div className="flex flex-col justify-center items-start">
                <div className="_title_1ebau_13">Type of Report</div>
                <div className="_description_1ebau_22">
                  Select type of report there
                </div>
              </div>
              <div className="flex flex-row justify-center items-center ml-auto">
                <div className="_arrow_1ebau_46" onClick={handleLeftClick}>
                  <svg
                    width="0.648vh"
                    height="1.11vh"
                    viewBox="0 0 7 12"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M6.34315 5.65686V6.19888e-06L0.686292 5.65686L6.34315 11.3137V5.65686Z"
                      fill="white"
                    />
                  </svg>
                </div>
                <div className="_box_1ebau_30">{texts[currentIndex]}</div>
                <div className="_arrow_1ebau_46" onClick={handleRightClick}>
                  <svg
                    width="0.648vh"
                    height="1.11vh"
                    viewBox="0 0 7 12"
                    fill="none"
                    xmlns="http://www.w3.org/2000/svg"
                  >
                    <path
                      d="M6.34315 5.65686V6.19888e-06L0.686292 5.65686L6.34315 11.3137V5.65686Z"
                      fill="white"
                    />
                  </svg>
                </div>
              </div>
            </div>
            <div className="_textArea_s5kwc_1">
              <div className="_header_s5kwc_10">
                <div className="_title_s5kwc_21">Title</div>
                <div className="_description_s5kwc_30">
                  Title of your report
                </div>
              </div>
              <textarea
                placeholder="Title of your report"
                className="_smallHeight_s5kwc_56"
                value={Title}
                onChange={e => setTitle(e.target.value)}
              />
            </div>
            <div className="_textArea_s5kwc_1">
              <div className="_header_s5kwc_10">
                <div className="_title_s5kwc_21">Description</div>
                <div className="_description_s5kwc_30">
                  Describe your situation or bug or whatever you feel need to be
                  here
                </div>
              </div>
              <textarea
                placeholder="Describe your situation or bug or whatever you feel need to be here"
                value={Description}
                onChange={e => setDescription(e.target.value)}
              />
            </div>
            <div className="_textArea_s5kwc_1">
              <div className="_header_s5kwc_10">
                <div className="_title_s5kwc_21">
                  VOD / Clip / Screenshot URLs
                </div>
                <div className="_description_s5kwc_30">
                  Must be separated by new line, include scrolling of F8 window
                  if bossible
                </div>
              </div>
              <textarea
                placeholder="Must be separated by new line, include scrolling of F8 window if bossible"
                value={URL}
                onChange={e => setURL(e.target.value)}
              />
            </div>
            <div className="_button_jxdi5_1" onClick={handleSubmit}>Submit</div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default App;

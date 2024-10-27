document.addEventListener('DOMContentLoaded', () => {
    const Modalladder = document.querySelector('.ladder');
    const Ready = document.getElementById('ready');
    const close = document.getElementById('back');
    const next = document.getElementById('next');
    const ModalScore = document.getElementById('score');
    const ScoreClose = document.getElementById('ScoreClose');
    const plusButtons = document.getElementsByClassName('plus');
    const minusButtons = document.getElementsByClassName('minus');
    const userValue = document.getElementById('user');
    const userBox = document.querySelector('.user_box ul'); // 유저 입력 필드 목록
    const eventBox = document.querySelector('.event_box ul');

    let currentValue = 2; // 초기값 설정
    userValue.textContent = currentValue; // 초기값 표시

    // 플러스 버튼
    for (let i = 0; i < plusButtons.length; i++) {
        plusButtons[i].addEventListener('click', () => {
            currentValue++;
            if (currentValue > 20) {
                currentValue = 20; // 최대값 제한
            }
            userValue.textContent = currentValue;
            updateUserBoxes(currentValue);
            updateEventBoxes(currentValue);
        });
    }

    // 마이너스 버튼
    for (let i = 0; i < minusButtons.length; i++) {
        minusButtons[i].addEventListener('click', () => {
            currentValue--;
            if (currentValue < 2) {
                currentValue = 2; // 최소값 제한
            }
            userValue.textContent = currentValue;
            updateUserBoxes(currentValue);
            updateEventBoxes(currentValue);
        });
    }

    // 유저 박스 업데이트 함수
    function updateUserBoxes(count) {
        userBox.innerHTML = ''; // 기존 박스 초기화
        for (let i = 0; i < count; i++) {
            const newLi = document.createElement('li');
            const userInnerBox = document.createElement('label');
            userInnerBox.className = 'user_innerbox';

            const input = document.createElement('input');
            input.type = 'text';
            input.placeholder = '이름';

            const lineBox = document.createElement('div');
            lineBox.className = 'line_box';

            userInnerBox.appendChild(input);
            userInnerBox.appendChild(lineBox);
            newLi.appendChild(userInnerBox);
            userBox.appendChild(newLi);
        }
    }

    // event_innerbox 업데이트 함수
    function updateEventBoxes(count) {
        eventBox.innerHTML = ''; // 기존 박스 초기화
        for (let i = 0; i < count; i++) {
            const newLi = document.createElement('li');
            const eventInnerBox = document.createElement('label');
            eventInnerBox.className = 'event_innerbox';

            const input = document.createElement('input');
            input.type = 'text';
            input.placeholder = '내용';

            eventInnerBox.appendChild(input);
            newLi.appendChild(eventInnerBox);
            eventBox.appendChild(newLi);
        }
    }

    // Ready 버튼 눌렀을 때 게임 시작! 모달창 오픈
    Ready.addEventListener('click', () => {
        updateUserBoxes(currentValue); // 모달 열기 전에 박스 업데이트
        updateEventBoxes(currentValue); // 모달 열기 전에 이벤트 박스 업데이트
        Modalladder.style.display = 'block'; 
    });

    // Back 버튼 눌렀을 때 모달창 닫기
    close.addEventListener('click', () => {
        Modalladder.style.display = 'none';
    });

    // START 버튼 눌렀을 때 게임 결과 모달창 오픈
    next.addEventListener('click', () => {
        Modalladder.style.display = 'none';
        ModalScore.style.display = 'block';
    });

    // X 표시 눌렀을 때 게임 결과 모달창 닫기
    ScoreClose.addEventListener('click', () => {
        ModalScore.style.display = 'none';
    });
});

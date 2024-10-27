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
            currentValue++; // 값 증가
            if (currentValue > 2 && currentValue <= 20) {
                userValue.textContent = currentValue; // 조건 만족 시 값 표시
            } else if (currentValue > 20) {
                currentValue = 20; // 최대값 제한
                userValue.textContent = currentValue;
            }
        });
    }

    // 마이너스 버튼
    for (let i = 0; i < minusButtons.length; i++) {
        minusButtons[i].addEventListener('click', () => {
            currentValue--; // 값 감소
            if (currentValue < 2) {
                currentValue = 2; // 최소값 제한
            }
            userValue.textContent = currentValue; // 항상 현재 값 표시
        });
    }


    // userValue.onchange = () => {
    //     row = userValue.value;
    //     section.innerHTML = '';
    //     for(let i = 0; i < row; i++){
    //         const newLi = document.createElement('label');
    //         section.appendChild(newLi);
    //     }
    // }


// 유저 박스 업데이트 함수
function updateUserBoxes(count) {
    // 기존 유저 박스 초기화
    userBox.innerHTML = '';
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

// event_innerbox 업데이트 (기본적으로 userValue와 같도록)
function updateEventBoxes(count) {
    eventBox.innerHTML = '';
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

// userValue 값이 변경될 때 이벤트 박스도 업데이트
userValue.onchange = () => {
    const row = parseInt(userValue.textContent); // 현재 userValue의 텍스트 가져오기
    updateUserBoxes(row); // 유저 박스 업데이트
    updateEventBoxes(row); // 이벤트 박스 업데이트
};


















    

    // Ready 버튼 눌렀을때 게임 시작! 모달창 오픈
    Ready.addEventListener('click', () => {
        Modalladder.style.display = 'block'; 
    });

    // Back 버튼 눌렀을때 모달창 닫기
    close.addEventListener('click', () => {
        Modalladder.style.display = 'none';
    });

    // START 버튼 눌렀을때 게임결과 모달창 오픈
    next.addEventListener('click', () => {
        Modalladder.style.display = 'none';
        ModalScore.style.display = 'block';
    });

    // X 표시 눌렀을때 게임결과 결과모달창 닫기
    ScoreClose.addEventListener('click', () => {
        ModalScore.style.display = 'none';
    });
});

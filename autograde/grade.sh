#!/bin/bash

cd /home/coder/project/autograde/
git clone https://github.com/hergin/cs690-coursera-isprime

cp /shared/submission/PrimeService.cs /home/coder/project/autograde/cs690-coursera-isprime/PrimeService/PrimeService.cs
cd /home/coder/project/autograde/cs690-coursera-isprime

test_result="$(dotnet test --nologo -v q)"

if [[ $test_result =~ Failed:[[:space:]]*0 ]]; then
    echo "{ \"fractionalScore\": 1.0, \"feedback\":\"\", \"feedbackType\": \"HTML\" }" > /shared/feedback.json
    echo "<b>Nothing failed!</b>" > /shared/htmlFeedback.html
else
    echo "{ \"fractionalScore\": 0.0, \"feedback\":\"\", \"feedbackType\": \"HTML\" }" > /shared/feedback.json
    echo "<b>Something failed and here is the result of the command:</b><br/><br/>"$test_result > /shared/htmlFeedback.html
fi
exit 0
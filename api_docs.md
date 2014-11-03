
# POST /topics

## Notes
This is an example of a creating a topic. Questions are created by providing a set of key value pairs that correspond to the question names and the questions that it will be quized against. You must explicitly state which questions you want a question to quiz against because it does not always make sense to quiz against all questions. In this example, we are creating a topic called 'chickens' and will review the 'breed' question against the 'color' and 'type' questions.



## Params
```
{
  "name": "chickens",
  "user_id": "1",
  "questions": {
    "breed": [
      "color",
      "type"
    ],
    "type": [

    ],
    "color": [
      "breed"
    ]
  }
}
```


## Response
```
{
  "topic": {
    "id": 1,
    "name": "chickens",
    "questions": [
      "color",
      "type",
      "chickens",
      "breed"
    ]
  }
}
```



# GET /topics



## Params
```
{
  "user_id": "1"
}
```


## Response
```
{
  "topics": [
    {
      "id": 1,
      "name": "한국어",
      "questions": [
        "한글",
        "영어",
        "품사",
        "발음"
      ]
    }
  ]
}
```




# POST /topics/1/facts



## Params
```
{
  "user_id": "1",
  "answers": {
    "한글": "명사",
    "영어": "a noun",
    "품사": "N",
    "발음": "명사.wav"
  },
  "topic_id": "1"
}
```


## Response
```
{
  "한글": [
    "명사"
  ],
  "영어": [
    "a noun"
  ],
  "품사": [
    "N"
  ],
  "발음": [
    "명사.wav"
  ]
}
```





# POST /topics/1/reviews



## Params
```
{
  "user_id": "1",
  "topic_id": "1"
}
```


## Response
```
{
  "reviews": [
    {
      "id": 8,
      "prompt_label": "한글",
      "prompt": "호박",
      "choices_label": "영어",
      "choices": [
        "pumpkin"
      ],
      "last_quiz_result": null
    },
    {
      "id": 9,
      "prompt_label": "한글",
      "prompt": "호박",
      "choices_label": "품사",
      "choices": [
        "명사"
      ],
      "last_quiz_result": null
    },
    {
      "id": 10,
      "prompt_label": "영어",
      "prompt": "pumpkin",
      "choices_label": "한글",
      "choices": [
        "호박"
      ],
      "last_quiz_result": null
    },
    {
      "id": 11,
      "prompt_label": "영어",
      "prompt": "pumpkin",
      "choices_label": "품사",
      "choices": [
        "명사"
      ],
      "last_quiz_result": null
    },
    {
      "id": 12,
      "prompt_label": "영어",
      "prompt": "pumpkin",
      "choices_label": "발음",
      "choices": [
        "호박.mp3"
      ],
      "last_quiz_result": null
    },
    {
      "id": 13,
      "prompt_label": "발음",
      "prompt": "호박.mp3",
      "choices_label": "영어",
      "choices": [
        "pumpkin"
      ],
      "last_quiz_result": null
    },
    {
      "id": 14,
      "prompt_label": "발음",
      "prompt": "호박.mp3",
      "choices_label": "품사",
      "choices": [
        "명사"
      ],
      "last_quiz_result": null
    }
  ]
}
```



# GET /topics/1/reviews



## Params
```
{
  "user_id": "1",
  "topic_id": "1"
}
```


## Response
```
{
  "reviews": [
    {
      "id": 1,
      "prompt_label": "한글",
      "prompt": "호박",
      "choices_label": "영어",
      "choices": [
        "pumpkin"
      ],
      "last_quiz_result": null
    },
    {
      "id": 2,
      "prompt_label": "한글",
      "prompt": "호박",
      "choices_label": "품사",
      "choices": [
        "명사"
      ],
      "last_quiz_result": null
    },
    {
      "id": 3,
      "prompt_label": "영어",
      "prompt": "pumpkin",
      "choices_label": "한글",
      "choices": [
        "호박"
      ],
      "last_quiz_result": null
    },
    {
      "id": 4,
      "prompt_label": "영어",
      "prompt": "pumpkin",
      "choices_label": "품사",
      "choices": [
        "명사"
      ],
      "last_quiz_result": null
    },
    {
      "id": 5,
      "prompt_label": "영어",
      "prompt": "pumpkin",
      "choices_label": "발음",
      "choices": [
        "호박.mp3"
      ],
      "last_quiz_result": null
    },
    {
      "id": 6,
      "prompt_label": "발음",
      "prompt": "호박.mp3",
      "choices_label": "영어",
      "choices": [
        "pumpkin"
      ],
      "last_quiz_result": null
    },
    {
      "id": 7,
      "prompt_label": "발음",
      "prompt": "호박.mp3",
      "choices_label": "품사",
      "choices": [
        "명사"
      ],
      "last_quiz_result": null
    }
  ]
}
```



# PATCH /topics/1/reviews/3



## Params
```
{
  "user_id": "1",
  "proposed": [
    "호박"
  ],
  "topic_id": "1"
}
```


## Response
```
{
  "proposed": [
    "호박"
  ],
  "actual": [
    "호박"
  ],
  "success": true
}
```




# PATCH /topics/1/reviews/5



## Params
```
{
  "user_id": "1",
  "proposed": [
    "wrong",
    "not correct"
  ],
  "topic_id": "1"
}
```


## Response
```
{
  "proposed": [
    "not correct",
    "wrong"
  ],
  "actual": [
    "호박.mp3"
  ],
  "success": false
}
```



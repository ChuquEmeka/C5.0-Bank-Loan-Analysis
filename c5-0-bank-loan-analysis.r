{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "bac38fcf",
   "metadata": {
    "papermill": {
     "duration": 0.100356,
     "end_time": "2022-01-23T13:13:05.381412",
     "exception": false,
     "start_time": "2022-01-23T13:13:05.281056",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# Identifying risky Bank Loans using C5.0 Decision Tree Algorithm\n",
    "\n",
    "### Presented by Edeh Emeka N."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "03927fae",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:05.591175Z",
     "iopub.status.busy": "2022-01-23T13:13:05.590499Z",
     "iopub.status.idle": "2022-01-23T13:13:05.847004Z",
     "shell.execute_reply": "2022-01-23T13:13:05.845212Z"
    },
    "papermill": {
     "duration": 0.366795,
     "end_time": "2022-01-23T13:13:05.847220",
     "exception": false,
     "start_time": "2022-01-23T13:13:05.480425",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "library(\"readr\")"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "fb7c588f",
   "metadata": {
    "papermill": {
     "duration": 0.101953,
     "end_time": "2022-01-23T13:13:06.049689",
     "exception": false,
     "start_time": "2022-01-23T13:13:05.947736",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## **DATA EXPLORATION**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "5a3ba4bc",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:06.289398Z",
     "iopub.status.busy": "2022-01-23T13:13:06.253231Z",
     "iopub.status.idle": "2022-01-23T13:13:06.366657Z",
     "shell.execute_reply": "2022-01-23T13:13:06.364840Z"
    },
    "papermill": {
     "duration": 0.217928,
     "end_time": "2022-01-23T13:13:06.366837",
     "exception": false,
     "start_time": "2022-01-23T13:13:06.148909",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t1000 obs. of  17 variables:\n",
      " $ checking_balance    : chr  \"< 0 DM\" \"1 - 200 DM\" \"unknown\" \"< 0 DM\" ...\n",
      " $ months_loan_duration: int  6 48 12 42 24 36 24 36 12 30 ...\n",
      " $ credit_history      : chr  \"critical\" \"good\" \"critical\" \"good\" ...\n",
      " $ purpose             : chr  \"furniture/appliances\" \"furniture/appliances\" \"education\" \"furniture/appliances\" ...\n",
      " $ amount              : int  1169 5951 2096 7882 4870 9055 2835 6948 3059 5234 ...\n",
      " $ savings_balance     : chr  \"unknown\" \"< 100 DM\" \"< 100 DM\" \"< 100 DM\" ...\n",
      " $ employment_duration : chr  \"> 7 years\" \"1 - 4 years\" \"4 - 7 years\" \"4 - 7 years\" ...\n",
      " $ percent_of_income   : int  4 2 2 2 3 2 3 2 2 4 ...\n",
      " $ years_at_residence  : int  4 2 3 4 4 4 4 2 4 2 ...\n",
      " $ age                 : int  67 22 49 45 53 35 53 35 61 28 ...\n",
      " $ other_credit        : chr  \"none\" \"none\" \"none\" \"none\" ...\n",
      " $ housing             : chr  \"own\" \"own\" \"own\" \"other\" ...\n",
      " $ existing_loans_count: int  2 1 1 1 2 1 1 1 1 2 ...\n",
      " $ job                 : chr  \"skilled\" \"skilled\" \"unskilled\" \"skilled\" ...\n",
      " $ dependents          : int  1 1 2 2 2 2 1 1 1 1 ...\n",
      " $ phone               : chr  \"yes\" \"no\" \"no\" \"no\" ...\n",
      " $ default             : chr  \"no\" \"yes\" \"no\" \"no\" ...\n"
     ]
    }
   ],
   "source": [
    "credit <- read.csv(\"../input/credit-default/credit.csv\")\n",
    "str(credit)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "217c1b10",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:06.580460Z",
     "iopub.status.busy": "2022-01-23T13:13:06.578251Z",
     "iopub.status.idle": "2022-01-23T13:13:06.607147Z",
     "shell.execute_reply": "2022-01-23T13:13:06.606461Z"
    },
    "papermill": {
     "duration": 0.137034,
     "end_time": "2022-01-23T13:13:06.607292",
     "exception": false,
     "start_time": "2022-01-23T13:13:06.470258",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       " checking_balance   months_loan_duration credit_history       purpose         \n",
       " Length:1000        Min.   : 4.0         Length:1000        Length:1000       \n",
       " Class :character   1st Qu.:12.0         Class :character   Class :character  \n",
       " Mode  :character   Median :18.0         Mode  :character   Mode  :character  \n",
       "                    Mean   :20.9                                              \n",
       "                    3rd Qu.:24.0                                              \n",
       "                    Max.   :72.0                                              \n",
       "     amount      savings_balance    employment_duration percent_of_income\n",
       " Min.   :  250   Length:1000        Length:1000         Min.   :1.000    \n",
       " 1st Qu.: 1366   Class :character   Class :character    1st Qu.:2.000    \n",
       " Median : 2320   Mode  :character   Mode  :character    Median :3.000    \n",
       " Mean   : 3271                                          Mean   :2.973    \n",
       " 3rd Qu.: 3972                                          3rd Qu.:4.000    \n",
       " Max.   :18424                                          Max.   :4.000    \n",
       " years_at_residence      age        other_credit         housing         \n",
       " Min.   :1.000      Min.   :19.00   Length:1000        Length:1000       \n",
       " 1st Qu.:2.000      1st Qu.:27.00   Class :character   Class :character  \n",
       " Median :3.000      Median :33.00   Mode  :character   Mode  :character  \n",
       " Mean   :2.845      Mean   :35.55                                        \n",
       " 3rd Qu.:4.000      3rd Qu.:42.00                                        \n",
       " Max.   :4.000      Max.   :75.00                                        \n",
       " existing_loans_count     job              dependents       phone          \n",
       " Min.   :1.000        Length:1000        Min.   :1.000   Length:1000       \n",
       " 1st Qu.:1.000        Class :character   1st Qu.:1.000   Class :character  \n",
       " Median :1.000        Mode  :character   Median :1.000   Mode  :character  \n",
       " Mean   :1.407                           Mean   :1.155                     \n",
       " 3rd Qu.:2.000                           3rd Qu.:1.000                     \n",
       " Max.   :4.000                           Max.   :2.000                     \n",
       "   default         \n",
       " Length:1000       \n",
       " Class :character  \n",
       " Mode  :character  \n",
       "                   \n",
       "                   \n",
       "                   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "summary(credit)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "c96a9d58",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:06.820080Z",
     "iopub.status.busy": "2022-01-23T13:13:06.818362Z",
     "iopub.status.idle": "2022-01-23T13:13:06.853824Z",
     "shell.execute_reply": "2022-01-23T13:13:06.852119Z"
    },
    "papermill": {
     "duration": 0.144069,
     "end_time": "2022-01-23T13:13:06.854021",
     "exception": false,
     "start_time": "2022-01-23T13:13:06.709952",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "    < 0 DM   > 200 DM 1 - 200 DM    unknown \n",
       "       274         63        269        394 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "     < 100 DM     > 1000 DM  100 - 500 DM 500 - 1000 DM       unknown \n",
       "          603            48           103            63           183 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Checking out features of the applicant's checking and savings account balance\n",
    "table(credit$checking_balance)\n",
    "table(credit$savings_balance)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "944fc442",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:07.074847Z",
     "iopub.status.busy": "2022-01-23T13:13:07.073312Z",
     "iopub.status.idle": "2022-01-23T13:13:07.090547Z",
     "shell.execute_reply": "2022-01-23T13:13:07.089011Z"
    },
    "papermill": {
     "duration": 0.129274,
     "end_time": "2022-01-23T13:13:07.090788",
     "exception": false,
     "start_time": "2022-01-23T13:13:06.961514",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "#Convert the credit$default column to factor\n",
    "credit$default <- as.factor(credit$default)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "72f273fa",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:07.311920Z",
     "iopub.status.busy": "2022-01-23T13:13:07.311150Z",
     "iopub.status.idle": "2022-01-23T13:13:07.336160Z",
     "shell.execute_reply": "2022-01-23T13:13:07.334504Z"
    },
    "papermill": {
     "duration": 0.138836,
     "end_time": "2022-01-23T13:13:07.336331",
     "exception": false,
     "start_time": "2022-01-23T13:13:07.197495",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. \n",
       "    4.0    12.0    18.0    20.9    24.0    72.0 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. \n",
       "    250    1366    2320    3271    3972   18424 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# look at two characteristics of the loan\n",
    "summary(credit$months_loan_duration)\n",
    "summary(credit$amount)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "788bdbbb",
   "metadata": {
    "papermill": {
     "duration": 0.110985,
     "end_time": "2022-01-23T13:13:07.557070",
     "exception": false,
     "start_time": "2022-01-23T13:13:07.446085",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**From the above summaries, it is evident that the loan amount ranges from 250 Deutsche Marks(DM) to 18,420 over a period of 4 to 72 months(the loan data was obtained from Germany and DM was the currency at the time).**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "8638b96a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:07.783270Z",
     "iopub.status.busy": "2022-01-23T13:13:07.781596Z",
     "iopub.status.idle": "2022-01-23T13:13:07.802316Z",
     "shell.execute_reply": "2022-01-23T13:13:07.800722Z"
    },
    "papermill": {
     "duration": 0.134942,
     "end_time": "2022-01-23T13:13:07.802503",
     "exception": false,
     "start_time": "2022-01-23T13:13:07.667561",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       " no yes \n",
       "700 300 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# look at the class variable\n",
    "table(credit$default)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1e3711c8",
   "metadata": {
    "papermill": {
     "duration": 0.111514,
     "end_time": "2022-01-23T13:13:08.026722",
     "exception": false,
     "start_time": "2022-01-23T13:13:07.915208",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**The above output is an indication that about 30% of the loans went into default**"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "56072399",
   "metadata": {
    "papermill": {
     "duration": 0.110074,
     "end_time": "2022-01-23T13:13:08.247226",
     "exception": false,
     "start_time": "2022-01-23T13:13:08.137152",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## **DATA PREPARATION**\n",
    "#### **CREATING RANDOM TRAINING AND TEST DATA**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "27ec084b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:08.482190Z",
     "iopub.status.busy": "2022-01-23T13:13:08.480689Z",
     "iopub.status.idle": "2022-01-23T13:13:08.506619Z",
     "shell.execute_reply": "2022-01-23T13:13:08.504898Z"
    },
    "papermill": {
     "duration": 0.148232,
     "end_time": "2022-01-23T13:13:08.506839",
     "exception": false,
     "start_time": "2022-01-23T13:13:08.358607",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>2</li><li>1000</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 2\n",
       "\\item 1000\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 2\n",
       "2. 1000\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1]    2 1000"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# creating a random sample for training and test data\n",
    "\n",
    "set.seed(123) #this will ensure an identical result in future since i am also using the sample()\n",
    "train_sample <- sample(1000, 700) #The sample() is used to perform Random sampling without replacement\n",
    "range(train_sample) #range shows you the MIN and MAX value\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "674e2941",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:08.746568Z",
     "iopub.status.busy": "2022-01-23T13:13:08.744851Z",
     "iopub.status.idle": "2022-01-23T13:13:08.764400Z",
     "shell.execute_reply": "2022-01-23T13:13:08.762970Z"
    },
    "papermill": {
     "duration": 0.138726,
     "end_time": "2022-01-23T13:13:08.764612",
     "exception": false,
     "start_time": "2022-01-23T13:13:08.625886",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      " int [1:700] 415 463 179 526 195 938 818 118 299 229 ...\n"
     ]
    }
   ],
   "source": [
    "str(train_sample)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "51259257",
   "metadata": {
    "papermill": {
     "duration": 0.116325,
     "end_time": "2022-01-23T13:13:08.996999",
     "exception": false,
     "start_time": "2022-01-23T13:13:08.880674",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**The above train data gives a vector of 700 random integers**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "96115613",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:09.233374Z",
     "iopub.status.busy": "2022-01-23T13:13:09.231836Z",
     "iopub.status.idle": "2022-01-23T13:13:09.250739Z",
     "shell.execute_reply": "2022-01-23T13:13:09.249238Z"
    },
    "papermill": {
     "duration": 0.138661,
     "end_time": "2022-01-23T13:13:09.250949",
     "exception": false,
     "start_time": "2022-01-23T13:13:09.112288",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# split the data frames\n",
    "credit_train <- credit[train_sample, ]\n",
    "credit_test  <- credit[-train_sample, ]"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "d003824c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:09.486559Z",
     "iopub.status.busy": "2022-01-23T13:13:09.485885Z",
     "iopub.status.idle": "2022-01-23T13:13:09.548259Z",
     "shell.execute_reply": "2022-01-23T13:13:09.546592Z"
    },
    "papermill": {
     "duration": 0.182887,
     "end_time": "2022-01-23T13:13:09.548415",
     "exception": false,
     "start_time": "2022-01-23T13:13:09.365528",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 17</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>checking_balance</th><th scope=col>months_loan_duration</th><th scope=col>credit_history</th><th scope=col>purpose</th><th scope=col>amount</th><th scope=col>savings_balance</th><th scope=col>employment_duration</th><th scope=col>percent_of_income</th><th scope=col>years_at_residence</th><th scope=col>age</th><th scope=col>other_credit</th><th scope=col>housing</th><th scope=col>existing_loans_count</th><th scope=col>job</th><th scope=col>dependents</th><th scope=col>phone</th><th scope=col>default</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>415</th><td><span style=white-space:pre-wrap>&lt; 0 DM    </span></td><td>24</td><td>good</td><td><span style=white-space:pre-wrap>car                 </span></td><td>1381</td><td><span style=white-space:pre-wrap>unknown     </span></td><td>1 - 4 years</td><td>4</td><td>2</td><td>35</td><td>none</td><td>own </td><td>1</td><td><span style=white-space:pre-wrap>skilled   </span></td><td>1</td><td>no </td><td>yes</td></tr>\n",
       "\t<tr><th scope=row>463</th><td>1 - 200 DM</td><td>12</td><td>good</td><td>furniture/appliances</td><td>3017</td><td><span style=white-space:pre-wrap>&lt; 100 DM    </span></td><td><span style=white-space:pre-wrap>&lt; 1 year   </span></td><td>3</td><td>1</td><td>34</td><td>none</td><td>rent</td><td>1</td><td>management</td><td>1</td><td>no </td><td>no </td></tr>\n",
       "\t<tr><th scope=row>179</th><td><span style=white-space:pre-wrap>unknown   </span></td><td>12</td><td>good</td><td>furniture/appliances</td><td>1963</td><td><span style=white-space:pre-wrap>&lt; 100 DM    </span></td><td>4 - 7 years</td><td>4</td><td>2</td><td>31</td><td>none</td><td>rent</td><td>2</td><td>management</td><td>2</td><td>yes</td><td>no </td></tr>\n",
       "\t<tr><th scope=row>526</th><td>1 - 200 DM</td><td>26</td><td>good</td><td><span style=white-space:pre-wrap>car                 </span></td><td>7966</td><td><span style=white-space:pre-wrap>&lt; 100 DM    </span></td><td><span style=white-space:pre-wrap>&lt; 1 year   </span></td><td>2</td><td>3</td><td>30</td><td>none</td><td>own </td><td>2</td><td><span style=white-space:pre-wrap>skilled   </span></td><td>1</td><td>no </td><td>no </td></tr>\n",
       "\t<tr><th scope=row>195</th><td>1 - 200 DM</td><td>45</td><td>good</td><td>furniture/appliances</td><td>3031</td><td>100 - 500 DM</td><td>1 - 4 years</td><td>4</td><td>4</td><td>21</td><td>none</td><td>rent</td><td>1</td><td>skilled   </td><td>1</td><td>no </td><td>yes</td></tr>\n",
       "\t<tr><th scope=row>938</th><td>1 - 200 DM</td><td> 6</td><td>good</td><td>furniture/appliances</td><td>2063</td><td><span style=white-space:pre-wrap>&lt; 100 DM    </span></td><td><span style=white-space:pre-wrap>&lt; 1 year   </span></td><td>4</td><td>3</td><td>30</td><td>none</td><td>rent</td><td>1</td><td>management</td><td>1</td><td>yes</td><td>no </td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 17\n",
       "\\begin{tabular}{r|lllllllllllllllll}\n",
       "  & checking\\_balance & months\\_loan\\_duration & credit\\_history & purpose & amount & savings\\_balance & employment\\_duration & percent\\_of\\_income & years\\_at\\_residence & age & other\\_credit & housing & existing\\_loans\\_count & job & dependents & phone & default\\\\\n",
       "  & <chr> & <int> & <chr> & <chr> & <int> & <chr> & <chr> & <int> & <int> & <int> & <chr> & <chr> & <int> & <chr> & <int> & <chr> & <fct>\\\\\n",
       "\\hline\n",
       "\t415 & < 0 DM     & 24 & good & car                  & 1381 & unknown      & 1 - 4 years & 4 & 2 & 35 & none & own  & 1 & skilled    & 1 & no  & yes\\\\\n",
       "\t463 & 1 - 200 DM & 12 & good & furniture/appliances & 3017 & < 100 DM     & < 1 year    & 3 & 1 & 34 & none & rent & 1 & management & 1 & no  & no \\\\\n",
       "\t179 & unknown    & 12 & good & furniture/appliances & 1963 & < 100 DM     & 4 - 7 years & 4 & 2 & 31 & none & rent & 2 & management & 2 & yes & no \\\\\n",
       "\t526 & 1 - 200 DM & 26 & good & car                  & 7966 & < 100 DM     & < 1 year    & 2 & 3 & 30 & none & own  & 2 & skilled    & 1 & no  & no \\\\\n",
       "\t195 & 1 - 200 DM & 45 & good & furniture/appliances & 3031 & 100 - 500 DM & 1 - 4 years & 4 & 4 & 21 & none & rent & 1 & skilled    & 1 & no  & yes\\\\\n",
       "\t938 & 1 - 200 DM &  6 & good & furniture/appliances & 2063 & < 100 DM     & < 1 year    & 4 & 3 & 30 & none & rent & 1 & management & 1 & yes & no \\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 17\n",
       "\n",
       "| <!--/--> | checking_balance &lt;chr&gt; | months_loan_duration &lt;int&gt; | credit_history &lt;chr&gt; | purpose &lt;chr&gt; | amount &lt;int&gt; | savings_balance &lt;chr&gt; | employment_duration &lt;chr&gt; | percent_of_income &lt;int&gt; | years_at_residence &lt;int&gt; | age &lt;int&gt; | other_credit &lt;chr&gt; | housing &lt;chr&gt; | existing_loans_count &lt;int&gt; | job &lt;chr&gt; | dependents &lt;int&gt; | phone &lt;chr&gt; | default &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 415 | &lt; 0 DM     | 24 | good | car                  | 1381 | unknown      | 1 - 4 years | 4 | 2 | 35 | none | own  | 1 | skilled    | 1 | no  | yes |\n",
       "| 463 | 1 - 200 DM | 12 | good | furniture/appliances | 3017 | &lt; 100 DM     | &lt; 1 year    | 3 | 1 | 34 | none | rent | 1 | management | 1 | no  | no  |\n",
       "| 179 | unknown    | 12 | good | furniture/appliances | 1963 | &lt; 100 DM     | 4 - 7 years | 4 | 2 | 31 | none | rent | 2 | management | 2 | yes | no  |\n",
       "| 526 | 1 - 200 DM | 26 | good | car                  | 7966 | &lt; 100 DM     | &lt; 1 year    | 2 | 3 | 30 | none | own  | 2 | skilled    | 1 | no  | no  |\n",
       "| 195 | 1 - 200 DM | 45 | good | furniture/appliances | 3031 | 100 - 500 DM | 1 - 4 years | 4 | 4 | 21 | none | rent | 1 | skilled    | 1 | no  | yes |\n",
       "| 938 | 1 - 200 DM |  6 | good | furniture/appliances | 2063 | &lt; 100 DM     | &lt; 1 year    | 4 | 3 | 30 | none | rent | 1 | management | 1 | yes | no  |\n",
       "\n"
      ],
      "text/plain": [
       "    checking_balance months_loan_duration credit_history purpose             \n",
       "415 < 0 DM           24                   good           car                 \n",
       "463 1 - 200 DM       12                   good           furniture/appliances\n",
       "179 unknown          12                   good           furniture/appliances\n",
       "526 1 - 200 DM       26                   good           car                 \n",
       "195 1 - 200 DM       45                   good           furniture/appliances\n",
       "938 1 - 200 DM        6                   good           furniture/appliances\n",
       "    amount savings_balance employment_duration percent_of_income\n",
       "415 1381   unknown         1 - 4 years         4                \n",
       "463 3017   < 100 DM        < 1 year            3                \n",
       "179 1963   < 100 DM        4 - 7 years         4                \n",
       "526 7966   < 100 DM        < 1 year            2                \n",
       "195 3031   100 - 500 DM    1 - 4 years         4                \n",
       "938 2063   < 100 DM        < 1 year            4                \n",
       "    years_at_residence age other_credit housing existing_loans_count job       \n",
       "415 2                  35  none         own     1                    skilled   \n",
       "463 1                  34  none         rent    1                    management\n",
       "179 2                  31  none         rent    2                    management\n",
       "526 3                  30  none         own     2                    skilled   \n",
       "195 4                  21  none         rent    1                    skilled   \n",
       "938 3                  30  none         rent    1                    management\n",
       "    dependents phone default\n",
       "415 1          no    yes    \n",
       "463 1          no    no     \n",
       "179 2          yes   no     \n",
       "526 1          no    no     \n",
       "195 1          no    yes    \n",
       "938 1          yes   no     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 6 × 17</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>checking_balance</th><th scope=col>months_loan_duration</th><th scope=col>credit_history</th><th scope=col>purpose</th><th scope=col>amount</th><th scope=col>savings_balance</th><th scope=col>employment_duration</th><th scope=col>percent_of_income</th><th scope=col>years_at_residence</th><th scope=col>age</th><th scope=col>other_credit</th><th scope=col>housing</th><th scope=col>existing_loans_count</th><th scope=col>job</th><th scope=col>dependents</th><th scope=col>phone</th><th scope=col>default</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;fct&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>1</th><td>&lt; 0 DM </td><td> 6</td><td>critical</td><td>furniture/appliances</td><td>1169</td><td><span style=white-space:pre-wrap>unknown      </span></td><td><span style=white-space:pre-wrap>&gt; 7 years  </span></td><td>4</td><td>4</td><td>67</td><td>none</td><td><span style=white-space:pre-wrap>own  </span></td><td>2</td><td><span style=white-space:pre-wrap>skilled  </span></td><td>1</td><td>yes</td><td>no </td></tr>\n",
       "\t<tr><th scope=row>3</th><td>unknown</td><td>12</td><td>critical</td><td><span style=white-space:pre-wrap>education           </span></td><td>2096</td><td><span style=white-space:pre-wrap>&lt; 100 DM     </span></td><td>4 - 7 years</td><td>2</td><td>3</td><td>49</td><td>none</td><td><span style=white-space:pre-wrap>own  </span></td><td>1</td><td>unskilled</td><td>2</td><td>no </td><td>no </td></tr>\n",
       "\t<tr><th scope=row>4</th><td>&lt; 0 DM </td><td>42</td><td><span style=white-space:pre-wrap>good    </span></td><td>furniture/appliances</td><td>7882</td><td><span style=white-space:pre-wrap>&lt; 100 DM     </span></td><td>4 - 7 years</td><td>2</td><td>4</td><td>45</td><td>none</td><td>other</td><td>1</td><td><span style=white-space:pre-wrap>skilled  </span></td><td>2</td><td>no </td><td>no </td></tr>\n",
       "\t<tr><th scope=row>7</th><td>unknown</td><td>24</td><td><span style=white-space:pre-wrap>good    </span></td><td>furniture/appliances</td><td>2835</td><td>500 - 1000 DM</td><td><span style=white-space:pre-wrap>&gt; 7 years  </span></td><td>3</td><td>4</td><td>53</td><td>none</td><td><span style=white-space:pre-wrap>own  </span></td><td>1</td><td><span style=white-space:pre-wrap>skilled  </span></td><td>1</td><td>no </td><td>no </td></tr>\n",
       "\t<tr><th scope=row>9</th><td>unknown</td><td>12</td><td><span style=white-space:pre-wrap>good    </span></td><td>furniture/appliances</td><td>3059</td><td><span style=white-space:pre-wrap>&gt; 1000 DM    </span></td><td>4 - 7 years</td><td>2</td><td>4</td><td>61</td><td>none</td><td><span style=white-space:pre-wrap>own  </span></td><td>1</td><td>unskilled</td><td>1</td><td>no </td><td>no </td></tr>\n",
       "\t<tr><th scope=row>12</th><td>&lt; 0 DM </td><td>48</td><td><span style=white-space:pre-wrap>good    </span></td><td><span style=white-space:pre-wrap>business            </span></td><td>4308</td><td><span style=white-space:pre-wrap>&lt; 100 DM     </span></td><td><span style=white-space:pre-wrap>&lt; 1 year   </span></td><td>3</td><td>4</td><td>24</td><td>none</td><td>rent </td><td>1</td><td><span style=white-space:pre-wrap>skilled  </span></td><td>1</td><td>no </td><td>yes</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 6 × 17\n",
       "\\begin{tabular}{r|lllllllllllllllll}\n",
       "  & checking\\_balance & months\\_loan\\_duration & credit\\_history & purpose & amount & savings\\_balance & employment\\_duration & percent\\_of\\_income & years\\_at\\_residence & age & other\\_credit & housing & existing\\_loans\\_count & job & dependents & phone & default\\\\\n",
       "  & <chr> & <int> & <chr> & <chr> & <int> & <chr> & <chr> & <int> & <int> & <int> & <chr> & <chr> & <int> & <chr> & <int> & <chr> & <fct>\\\\\n",
       "\\hline\n",
       "\t1 & < 0 DM  &  6 & critical & furniture/appliances & 1169 & unknown       & > 7 years   & 4 & 4 & 67 & none & own   & 2 & skilled   & 1 & yes & no \\\\\n",
       "\t3 & unknown & 12 & critical & education            & 2096 & < 100 DM      & 4 - 7 years & 2 & 3 & 49 & none & own   & 1 & unskilled & 2 & no  & no \\\\\n",
       "\t4 & < 0 DM  & 42 & good     & furniture/appliances & 7882 & < 100 DM      & 4 - 7 years & 2 & 4 & 45 & none & other & 1 & skilled   & 2 & no  & no \\\\\n",
       "\t7 & unknown & 24 & good     & furniture/appliances & 2835 & 500 - 1000 DM & > 7 years   & 3 & 4 & 53 & none & own   & 1 & skilled   & 1 & no  & no \\\\\n",
       "\t9 & unknown & 12 & good     & furniture/appliances & 3059 & > 1000 DM     & 4 - 7 years & 2 & 4 & 61 & none & own   & 1 & unskilled & 1 & no  & no \\\\\n",
       "\t12 & < 0 DM  & 48 & good     & business             & 4308 & < 100 DM      & < 1 year    & 3 & 4 & 24 & none & rent  & 1 & skilled   & 1 & no  & yes\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 6 × 17\n",
       "\n",
       "| <!--/--> | checking_balance &lt;chr&gt; | months_loan_duration &lt;int&gt; | credit_history &lt;chr&gt; | purpose &lt;chr&gt; | amount &lt;int&gt; | savings_balance &lt;chr&gt; | employment_duration &lt;chr&gt; | percent_of_income &lt;int&gt; | years_at_residence &lt;int&gt; | age &lt;int&gt; | other_credit &lt;chr&gt; | housing &lt;chr&gt; | existing_loans_count &lt;int&gt; | job &lt;chr&gt; | dependents &lt;int&gt; | phone &lt;chr&gt; | default &lt;fct&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| 1 | &lt; 0 DM  |  6 | critical | furniture/appliances | 1169 | unknown       | &gt; 7 years   | 4 | 4 | 67 | none | own   | 2 | skilled   | 1 | yes | no  |\n",
       "| 3 | unknown | 12 | critical | education            | 2096 | &lt; 100 DM      | 4 - 7 years | 2 | 3 | 49 | none | own   | 1 | unskilled | 2 | no  | no  |\n",
       "| 4 | &lt; 0 DM  | 42 | good     | furniture/appliances | 7882 | &lt; 100 DM      | 4 - 7 years | 2 | 4 | 45 | none | other | 1 | skilled   | 2 | no  | no  |\n",
       "| 7 | unknown | 24 | good     | furniture/appliances | 2835 | 500 - 1000 DM | &gt; 7 years   | 3 | 4 | 53 | none | own   | 1 | skilled   | 1 | no  | no  |\n",
       "| 9 | unknown | 12 | good     | furniture/appliances | 3059 | &gt; 1000 DM     | 4 - 7 years | 2 | 4 | 61 | none | own   | 1 | unskilled | 1 | no  | no  |\n",
       "| 12 | &lt; 0 DM  | 48 | good     | business             | 4308 | &lt; 100 DM      | &lt; 1 year    | 3 | 4 | 24 | none | rent  | 1 | skilled   | 1 | no  | yes |\n",
       "\n"
      ],
      "text/plain": [
       "   checking_balance months_loan_duration credit_history purpose             \n",
       "1  < 0 DM            6                   critical       furniture/appliances\n",
       "3  unknown          12                   critical       education           \n",
       "4  < 0 DM           42                   good           furniture/appliances\n",
       "7  unknown          24                   good           furniture/appliances\n",
       "9  unknown          12                   good           furniture/appliances\n",
       "12 < 0 DM           48                   good           business            \n",
       "   amount savings_balance employment_duration percent_of_income\n",
       "1  1169   unknown         > 7 years           4                \n",
       "3  2096   < 100 DM        4 - 7 years         2                \n",
       "4  7882   < 100 DM        4 - 7 years         2                \n",
       "7  2835   500 - 1000 DM   > 7 years           3                \n",
       "9  3059   > 1000 DM       4 - 7 years         2                \n",
       "12 4308   < 100 DM        < 1 year            3                \n",
       "   years_at_residence age other_credit housing existing_loans_count job      \n",
       "1  4                  67  none         own     2                    skilled  \n",
       "3  3                  49  none         own     1                    unskilled\n",
       "4  4                  45  none         other   1                    skilled  \n",
       "7  4                  53  none         own     1                    skilled  \n",
       "9  4                  61  none         own     1                    unskilled\n",
       "12 4                  24  none         rent    1                    skilled  \n",
       "   dependents phone default\n",
       "1  1          yes   no     \n",
       "3  2          no    no     \n",
       "4  2          no    no     \n",
       "7  1          no    no     \n",
       "9  1          no    no     \n",
       "12 1          no    yes    "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "head(credit_train)\n",
    "\n",
    "head(credit_test)\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "cc454b2a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:09.801894Z",
     "iopub.status.busy": "2022-01-23T13:13:09.799516Z",
     "iopub.status.idle": "2022-01-23T13:13:09.889304Z",
     "shell.execute_reply": "2022-01-23T13:13:09.887725Z"
    },
    "papermill": {
     "duration": 0.215982,
     "end_time": "2022-01-23T13:13:09.889498",
     "exception": false,
     "start_time": "2022-01-23T13:13:09.673516",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "       no       yes \n",
       "0.7085714 0.2914286 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "      no      yes \n",
       "70.85714 29.14286 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "  no  yes \n",
       "0.68 0.32 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       " no yes \n",
       " 68  32 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# check the proportion of class variable\n",
    "prop.table(table(credit_train$default))\n",
    "prop.table(table(credit_train$default))*100\n",
    "\n",
    "prop.table(table(credit_test$default))\n",
    "prop.table(table(credit_test$default))*100"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "cd3c4325",
   "metadata": {
    "papermill": {
     "duration": 0.140094,
     "end_time": "2022-01-23T13:13:10.160214",
     "exception": false,
     "start_time": "2022-01-23T13:13:10.020120",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**This appears to be evenly splitted since we have approximately 30% of defaulted loans in both the train and test datasets.**"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "af648fd3",
   "metadata": {
    "papermill": {
     "duration": 0.144969,
     "end_time": "2022-01-23T13:13:10.438091",
     "exception": false,
     "start_time": "2022-01-23T13:13:10.293122",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## **Training a model on the data**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "818f9091",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:10.709808Z",
     "iopub.status.busy": "2022-01-23T13:13:10.706860Z",
     "iopub.status.idle": "2022-01-23T13:13:55.269296Z",
     "shell.execute_reply": "2022-01-23T13:13:55.268264Z"
    },
    "papermill": {
     "duration": 44.70183,
     "end_time": "2022-01-23T13:13:55.269542",
     "exception": false,
     "start_time": "2022-01-23T13:13:10.567712",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n",
      "also installing the dependency ‘Cubist’\n",
      "\n",
      "\n"
     ]
    }
   ],
   "source": [
    "# build the simplest decision tree\n",
    "install.packages(\"C50\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "b7c7772a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:55.539283Z",
     "iopub.status.busy": "2022-01-23T13:13:55.537233Z",
     "iopub.status.idle": "2022-01-23T13:13:55.555162Z",
     "shell.execute_reply": "2022-01-23T13:13:55.553705Z"
    },
    "papermill": {
     "duration": 0.152366,
     "end_time": "2022-01-23T13:13:55.555359",
     "exception": false,
     "start_time": "2022-01-23T13:13:55.402993",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "credit_train$default<-as.factor(credit_train$default)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "654eb57f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:55.823608Z",
     "iopub.status.busy": "2022-01-23T13:13:55.822072Z",
     "iopub.status.idle": "2022-01-23T13:13:57.362064Z",
     "shell.execute_reply": "2022-01-23T13:13:57.360585Z"
    },
    "papermill": {
     "duration": 1.675828,
     "end_time": "2022-01-23T13:13:57.362258",
     "exception": false,
     "start_time": "2022-01-23T13:13:55.686430",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "library(C50)\n",
    "credit_model <- C5.0(credit_train[-17], credit_train$default)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "6867c4f7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:57.635912Z",
     "iopub.status.busy": "2022-01-23T13:13:57.633751Z",
     "iopub.status.idle": "2022-01-23T13:13:57.658242Z",
     "shell.execute_reply": "2022-01-23T13:13:57.656331Z"
    },
    "papermill": {
     "duration": 0.161204,
     "end_time": "2022-01-23T13:13:57.658412",
     "exception": false,
     "start_time": "2022-01-23T13:13:57.497208",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "C5.0.default(x = credit_train[-17], y = credit_train$default)\n",
       "\n",
       "Classification Tree\n",
       "Number of samples: 700 \n",
       "Number of predictors: 16 \n",
       "\n",
       "Tree size: 52 \n",
       "\n",
       "Non-standard options: attempt to group attributes\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# display simple facts about the tree\n",
    "credit_model"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "9bcff0f6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:57.933858Z",
     "iopub.status.busy": "2022-01-23T13:13:57.931605Z",
     "iopub.status.idle": "2022-01-23T13:13:57.955526Z",
     "shell.execute_reply": "2022-01-23T13:13:57.953373Z"
    },
    "papermill": {
     "duration": 0.161364,
     "end_time": "2022-01-23T13:13:57.955749",
     "exception": false,
     "start_time": "2022-01-23T13:13:57.794385",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "C5.0.default(x = credit_train[-17], y = credit_train$default)\n",
       "\n",
       "\n",
       "C5.0 [Release 2.07 GPL Edition]  \tSun Jan 23 13:13:57 2022\n",
       "-------------------------------\n",
       "\n",
       "Class specified by attribute `outcome'\n",
       "\n",
       "Read 700 cases (17 attributes) from undefined.data\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance = unknown: no (272/31)\n",
       "checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       ":...months_loan_duration > 42:\n",
       "    :...savings_balance in {500 - 1000 DM,> 1000 DM}: yes (0)\n",
       "    :   savings_balance = unknown: no (5)\n",
       "    :   savings_balance in {< 100 DM,100 - 500 DM}:\n",
       "    :   :...years_at_residence <= 1: no (3/1)\n",
       "    :       years_at_residence > 1: yes (29/2)\n",
       "    months_loan_duration <= 42:\n",
       "    :...credit_history in {very good,perfect}:\n",
       "        :...age <= 23: no (4)\n",
       "        :   age > 23:\n",
       "        :   :...percent_of_income > 3: yes (21/2)\n",
       "        :       percent_of_income <= 3:\n",
       "        :       :...dependents > 1: yes (2)\n",
       "        :           dependents <= 1:\n",
       "        :           :...housing = rent: yes (3)\n",
       "        :               housing in {own,other}:\n",
       "        :               :...other_credit = bank: no (8/2)\n",
       "        :                   other_credit = store: yes (1)\n",
       "        :                   other_credit = none:\n",
       "        :                   :...years_at_residence <= 2: no (4)\n",
       "        :                       years_at_residence > 2: yes (3)\n",
       "        credit_history in {good,critical,poor}:\n",
       "        :...months_loan_duration <= 11: no (77/12)\n",
       "            months_loan_duration > 11:\n",
       "            :...purpose in {business,car0}: no (27/4)\n",
       "                purpose = renovations: yes (6/2)\n",
       "                purpose = education:\n",
       "                :...dependents > 1: yes (2)\n",
       "                :   dependents <= 1:\n",
       "                :   :...checking_balance in {1 - 200 DM,> 200 DM}: no (5)\n",
       "                :       checking_balance = < 0 DM:\n",
       "                :       :...savings_balance = unknown: no (2)\n",
       "                :           savings_balance in {< 100 DM,100 - 500 DM,\n",
       "                :                               500 - 1000 DM,\n",
       "                :                               > 1000 DM}: yes (4)\n",
       "                purpose = car:\n",
       "                :...amount <= 1301:\n",
       "                :   :...age <= 62: yes (17/1)\n",
       "                :   :   age > 62: no (2)\n",
       "                :   amount > 1301:\n",
       "                :   :...amount > 11054: yes (4)\n",
       "                :       amount <= 11054:\n",
       "                :       :...checking_balance in {1 - 200 DM,\n",
       "                :           :                    > 200 DM}: no (34/6)\n",
       "                :           checking_balance = < 0 DM:\n",
       "                :           :...job in {management,unemployed}: no (7)\n",
       "                :               job in {skilled,unskilled}: [S1]\n",
       "                purpose = furniture/appliances:\n",
       "                :...savings_balance = 100 - 500 DM: yes (10/3)\n",
       "                    savings_balance = > 1000 DM: no (4)\n",
       "                    savings_balance = 500 - 1000 DM:\n",
       "                    :...credit_history in {good,poor}: no (5/1)\n",
       "                    :   credit_history = critical: yes (1)\n",
       "                    savings_balance = unknown:\n",
       "                    :...housing = other: no (0)\n",
       "                    :   housing = rent: yes (3/1)\n",
       "                    :   housing = own:\n",
       "                    :   :...amount <= 5771: no (13)\n",
       "                    :       amount > 5771: yes (3/1)\n",
       "                    savings_balance = < 100 DM:\n",
       "                    :...months_loan_duration <= 14: no (29/3)\n",
       "                        months_loan_duration > 14:\n",
       "                        :...credit_history = critical: no (19/5)\n",
       "                            credit_history = poor: yes (5/1)\n",
       "                            credit_history = good:\n",
       "                            :...phone = yes:\n",
       "                                :...months_loan_duration <= 30: yes (7)\n",
       "                                :   months_loan_duration > 30: no (2)\n",
       "                                phone = no:\n",
       "                                :...percent_of_income <= 1: no (3)\n",
       "                                    percent_of_income > 1:\n",
       "                                    :...dependents > 1: yes (5)\n",
       "                                        dependents <= 1: [S2]\n",
       "\n",
       "SubTree [S1]\n",
       "\n",
       "employment_duration in {< 1 year,4 - 7 years}: yes (7)\n",
       "employment_duration in {> 7 years,unemployed}: no (4/1)\n",
       "employment_duration = 1 - 4 years:\n",
       ":...years_at_residence <= 3: yes (6/1)\n",
       "    years_at_residence > 3:\n",
       "    :...housing in {own,rent}: no (4)\n",
       "        housing = other: yes (1)\n",
       "\n",
       "SubTree [S2]\n",
       "\n",
       "employment_duration in {4 - 7 years,> 7 years}: no (7/1)\n",
       "employment_duration = unemployed: yes (2)\n",
       "employment_duration = < 1 year:\n",
       ":...years_at_residence <= 2: no (4)\n",
       ":   years_at_residence > 2: yes (3)\n",
       "employment_duration = 1 - 4 years:\n",
       ":...months_loan_duration > 21: no (5/1)\n",
       "    months_loan_duration <= 21:\n",
       "    :...job in {skilled,management,unemployed}: yes (5)\n",
       "        job = unskilled: no (1)\n",
       "\n",
       "\n",
       "Evaluation on training data (700 cases):\n",
       "\n",
       "\t    Decision Tree   \n",
       "\t  ----------------  \n",
       "\t  Size      Errors  \n",
       "\n",
       "\t    50   82(11.7%)   <<\n",
       "\n",
       "\n",
       "\t   (a)   (b)    <-classified as\n",
       "\t  ----  ----\n",
       "\t   482    14    (a): class no\n",
       "\t    68   136    (b): class yes\n",
       "\n",
       "\n",
       "\tAttribute usage:\n",
       "\n",
       "\t100.00%\tchecking_balance\n",
       "\t 61.14%\tmonths_loan_duration\n",
       "\t 55.86%\tcredit_history\n",
       "\t 38.29%\tpurpose\n",
       "\t 25.57%\tsavings_balance\n",
       "\t 14.57%\tamount\n",
       "\t 11.00%\tpercent_of_income\n",
       "\t  9.43%\tdependents\n",
       "\t  9.29%\tage\n",
       "\t  8.14%\tyears_at_residence\n",
       "\t  7.00%\temployment_duration\n",
       "\t  6.29%\tphone\n",
       "\t  6.14%\thousing\n",
       "\t  5.00%\tjob\n",
       "\t  2.29%\tother_credit\n",
       "\n",
       "\n",
       "Time: 0.0 secs\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# display detailed information about the tree\n",
    "summary(credit_model)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "3b6f6b1b",
   "metadata": {
    "papermill": {
     "duration": 0.135418,
     "end_time": "2022-01-23T13:13:58.226275",
     "exception": false,
     "start_time": "2022-01-23T13:13:58.090857",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**from the above output, it can be seen that the model only  \n",
    "wrongly classified 82(11.7%) of the 700 training instances  \n",
    "with an accuracy score of 88.3%**"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "4b8c0842",
   "metadata": {
    "papermill": {
     "duration": 0.13339,
     "end_time": "2022-01-23T13:13:58.493045",
     "exception": false,
     "start_time": "2022-01-23T13:13:58.359655",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## **Evaluating model performance**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "3ae9a80e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:58.769227Z",
     "iopub.status.busy": "2022-01-23T13:13:58.766208Z",
     "iopub.status.idle": "2022-01-23T13:13:58.834370Z",
     "shell.execute_reply": "2022-01-23T13:13:58.832338Z"
    },
    "papermill": {
     "duration": 0.208989,
     "end_time": "2022-01-23T13:13:58.834557",
     "exception": false,
     "start_time": "2022-01-23T13:13:58.625568",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>no</li><li>no</li><li>yes</li><li>no</li><li>no</li><li>yes</li></ol>\n",
       "\n",
       "<details>\n",
       "\t<summary style=display:list-item;cursor:pointer>\n",
       "\t\t<strong>Levels</strong>:\n",
       "\t</summary>\n",
       "\t<style>\n",
       "\t.list-inline {list-style: none; margin:0; padding: 0}\n",
       "\t.list-inline>li {display: inline-block}\n",
       "\t.list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "\t</style>\n",
       "\t<ol class=list-inline><li>'no'</li><li>'yes'</li></ol>\n",
       "</details>"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item no\n",
       "\\item no\n",
       "\\item yes\n",
       "\\item no\n",
       "\\item no\n",
       "\\item yes\n",
       "\\end{enumerate*}\n",
       "\n",
       "\\emph{Levels}: \\begin{enumerate*}\n",
       "\\item 'no'\n",
       "\\item 'yes'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. no\n",
       "2. no\n",
       "3. yes\n",
       "4. no\n",
       "5. no\n",
       "6. yes\n",
       "\n",
       "\n",
       "\n",
       "**Levels**: 1. 'no'\n",
       "2. 'yes'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "[1] no  no  yes no  no  yes\n",
       "Levels: no yes"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "\n",
    "# create a factor vector of predictions on test data\n",
    "credit_pred <- predict(credit_model, credit_test)\n",
    "head(credit_pred)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7d7c6523",
   "metadata": {
    "papermill": {
     "duration": 0.136826,
     "end_time": "2022-01-23T13:13:59.111569",
     "exception": false,
     "start_time": "2022-01-23T13:13:58.974743",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "#### cross tabulation of predicted versus actual classes using gmodels"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "d1e39400",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:13:59.391616Z",
     "iopub.status.busy": "2022-01-23T13:13:59.389527Z",
     "iopub.status.idle": "2022-01-23T13:14:09.967058Z",
     "shell.execute_reply": "2022-01-23T13:14:09.965365Z"
    },
    "papermill": {
     "duration": 10.719504,
     "end_time": "2022-01-23T13:14:09.967324",
     "exception": false,
     "start_time": "2022-01-23T13:13:59.247820",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "Installing package into ‘/usr/local/lib/R/site-library’\n",
      "(as ‘lib’ is unspecified)\n",
      "\n"
     ]
    }
   ],
   "source": [
    "# cross tabulation of predicted versus actual classes\n",
    "install.packages(\"gmodels\")\n",
    "library(gmodels)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "40ffed1e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:14:10.255089Z",
     "iopub.status.busy": "2022-01-23T13:14:10.252561Z",
     "iopub.status.idle": "2022-01-23T13:14:10.285463Z",
     "shell.execute_reply": "2022-01-23T13:14:10.284039Z"
    },
    "papermill": {
     "duration": 0.178422,
     "end_time": "2022-01-23T13:14:10.285666",
     "exception": false,
     "start_time": "2022-01-23T13:14:10.107244",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " \n",
      "   Cell Contents\n",
      "|-------------------------|\n",
      "|                       N |\n",
      "|         N / Table Total |\n",
      "|-------------------------|\n",
      "\n",
      " \n",
      "Total Observations in Table:  300 \n",
      "\n",
      " \n",
      "               | predicted default \n",
      "actual default |        no |       yes | Row Total | \n",
      "---------------|-----------|-----------|-----------|\n",
      "            no |       176 |        28 |       204 | \n",
      "               |     0.587 |     0.093 |           | \n",
      "---------------|-----------|-----------|-----------|\n",
      "           yes |        55 |        41 |        96 | \n",
      "               |     0.183 |     0.137 |           | \n",
      "---------------|-----------|-----------|-----------|\n",
      "  Column Total |       231 |        69 |       300 | \n",
      "---------------|-----------|-----------|-----------|\n",
      "\n",
      " \n"
     ]
    }
   ],
   "source": [
    "#to remove the column and row percentages, i will set prop.c and prop.r parameters to false\n",
    "accuracy_chk<- CrossTable(credit_test$default, credit_pred,\n",
    "           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,\n",
    "           dnn = c('actual default', 'predicted default'))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "07e11e83",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:14:10.578452Z",
     "iopub.status.busy": "2022-01-23T13:14:10.576598Z",
     "iopub.status.idle": "2022-01-23T13:14:10.601147Z",
     "shell.execute_reply": "2022-01-23T13:14:10.599497Z"
    },
    "papermill": {
     "duration": 0.172618,
     "end_time": "2022-01-23T13:14:10.601347",
     "exception": false,
     "start_time": "2022-01-23T13:14:10.428729",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "     credit_pred\n",
       "       no yes\n",
       "  no  176  28\n",
       "  yes  55  41"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#getting the prediction matrix\n",
    "accuracy_chk<-table(credit_test$default, credit_pred)\n",
    "\n",
    "accuracy_chk"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "e4b0e901",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:14:10.902341Z",
     "iopub.status.busy": "2022-01-23T13:14:10.900425Z",
     "iopub.status.idle": "2022-01-23T13:14:10.924680Z",
     "shell.execute_reply": "2022-01-23T13:14:10.922917Z"
    },
    "papermill": {
     "duration": 0.174633,
     "end_time": "2022-01-23T13:14:10.924876",
     "exception": false,
     "start_time": "2022-01-23T13:14:10.750243",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "0.723333333333333"
      ],
      "text/latex": [
       "0.723333333333333"
      ],
      "text/markdown": [
       "0.723333333333333"
      ],
      "text/plain": [
       "[1] 0.7233333"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "#Calculating the accuracy of the model\n",
    "accuracy_result<- sum(diag(accuracy_chk))/sum(accuracy_chk)\n",
    "accuracy_result\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "35528a76",
   "metadata": {
    "papermill": {
     "duration": 0.144444,
     "end_time": "2022-01-23T13:14:11.227567",
     "exception": false,
     "start_time": "2022-01-23T13:14:11.083123",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Of the 300 test loan application records, the model correctly predicted that 176 did not default and 41 defaulted with an accuracy score of about 72% which is worse than what was obtained in the training data.**"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "32ed0732",
   "metadata": {
    "papermill": {
     "duration": 0.142903,
     "end_time": "2022-01-23T13:14:11.513473",
     "exception": false,
     "start_time": "2022-01-23T13:14:11.370570",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "## **Improving model performance**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "e3d375c0",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:14:11.808661Z",
     "iopub.status.busy": "2022-01-23T13:14:11.807060Z",
     "iopub.status.idle": "2022-01-23T13:14:11.933229Z",
     "shell.execute_reply": "2022-01-23T13:14:11.932549Z"
    },
    "papermill": {
     "duration": 0.277314,
     "end_time": "2022-01-23T13:14:11.933381",
     "exception": false,
     "start_time": "2022-01-23T13:14:11.656067",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "C5.0.default(x = credit_train[-17], y = credit_train$default, trials = 10)\n",
       "\n",
       "Classification Tree\n",
       "Number of samples: 700 \n",
       "Number of predictors: 16 \n",
       "\n",
       "Number of boosting iterations: 10 \n",
       "Average tree size: 43.8 \n",
       "\n",
       "Non-standard options: attempt to group attributes\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "text/plain": [
       "\n",
       "Call:\n",
       "C5.0.default(x = credit_train[-17], y = credit_train$default, trials = 10)\n",
       "\n",
       "\n",
       "C5.0 [Release 2.07 GPL Edition]  \tSun Jan 23 13:14:11 2022\n",
       "-------------------------------\n",
       "\n",
       "Class specified by attribute `outcome'\n",
       "\n",
       "Read 700 cases (17 attributes) from undefined.data\n",
       "\n",
       "-----  Trial 0:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance = unknown: no (272/31)\n",
       "checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       ":...months_loan_duration > 42:\n",
       "    :...savings_balance in {500 - 1000 DM,> 1000 DM}: yes (0)\n",
       "    :   savings_balance = unknown: no (5)\n",
       "    :   savings_balance in {< 100 DM,100 - 500 DM}:\n",
       "    :   :...years_at_residence <= 1: no (3/1)\n",
       "    :       years_at_residence > 1: yes (29/2)\n",
       "    months_loan_duration <= 42:\n",
       "    :...credit_history in {very good,perfect}:\n",
       "        :...age <= 23: no (4)\n",
       "        :   age > 23:\n",
       "        :   :...percent_of_income > 3: yes (21/2)\n",
       "        :       percent_of_income <= 3:\n",
       "        :       :...dependents > 1: yes (2)\n",
       "        :           dependents <= 1:\n",
       "        :           :...housing = rent: yes (3)\n",
       "        :               housing in {own,other}:\n",
       "        :               :...other_credit = bank: no (8/2)\n",
       "        :                   other_credit = store: yes (1)\n",
       "        :                   other_credit = none:\n",
       "        :                   :...years_at_residence <= 2: no (4)\n",
       "        :                       years_at_residence > 2: yes (3)\n",
       "        credit_history in {good,critical,poor}:\n",
       "        :...months_loan_duration <= 11: no (77/12)\n",
       "            months_loan_duration > 11:\n",
       "            :...purpose in {business,car0}: no (27/4)\n",
       "                purpose = renovations: yes (6/2)\n",
       "                purpose = education:\n",
       "                :...dependents > 1: yes (2)\n",
       "                :   dependents <= 1:\n",
       "                :   :...checking_balance in {1 - 200 DM,> 200 DM}: no (5)\n",
       "                :       checking_balance = < 0 DM:\n",
       "                :       :...savings_balance = unknown: no (2)\n",
       "                :           savings_balance in {< 100 DM,100 - 500 DM,\n",
       "                :                               500 - 1000 DM,\n",
       "                :                               > 1000 DM}: yes (4)\n",
       "                purpose = car:\n",
       "                :...amount <= 1301:\n",
       "                :   :...age <= 62: yes (17/1)\n",
       "                :   :   age > 62: no (2)\n",
       "                :   amount > 1301:\n",
       "                :   :...amount > 11054: yes (4)\n",
       "                :       amount <= 11054:\n",
       "                :       :...checking_balance in {1 - 200 DM,\n",
       "                :           :                    > 200 DM}: no (34/6)\n",
       "                :           checking_balance = < 0 DM:\n",
       "                :           :...job in {management,unemployed}: no (7)\n",
       "                :               job in {skilled,unskilled}: [S1]\n",
       "                purpose = furniture/appliances:\n",
       "                :...savings_balance = 100 - 500 DM: yes (10/3)\n",
       "                    savings_balance = > 1000 DM: no (4)\n",
       "                    savings_balance = 500 - 1000 DM:\n",
       "                    :...credit_history in {good,poor}: no (5/1)\n",
       "                    :   credit_history = critical: yes (1)\n",
       "                    savings_balance = unknown:\n",
       "                    :...housing = other: no (0)\n",
       "                    :   housing = rent: yes (3/1)\n",
       "                    :   housing = own:\n",
       "                    :   :...amount <= 5771: no (13)\n",
       "                    :       amount > 5771: yes (3/1)\n",
       "                    savings_balance = < 100 DM:\n",
       "                    :...months_loan_duration <= 14: no (29/3)\n",
       "                        months_loan_duration > 14:\n",
       "                        :...credit_history = critical: no (19/5)\n",
       "                            credit_history = poor: yes (5/1)\n",
       "                            credit_history = good:\n",
       "                            :...phone = yes:\n",
       "                                :...months_loan_duration <= 30: yes (7)\n",
       "                                :   months_loan_duration > 30: no (2)\n",
       "                                phone = no:\n",
       "                                :...percent_of_income <= 1: no (3)\n",
       "                                    percent_of_income > 1:\n",
       "                                    :...dependents > 1: yes (5)\n",
       "                                        dependents <= 1: [S2]\n",
       "\n",
       "SubTree [S1]\n",
       "\n",
       "employment_duration in {< 1 year,4 - 7 years}: yes (7)\n",
       "employment_duration in {> 7 years,unemployed}: no (4/1)\n",
       "employment_duration = 1 - 4 years:\n",
       ":...years_at_residence <= 3: yes (6/1)\n",
       "    years_at_residence > 3:\n",
       "    :...housing in {own,rent}: no (4)\n",
       "        housing = other: yes (1)\n",
       "\n",
       "SubTree [S2]\n",
       "\n",
       "employment_duration in {4 - 7 years,> 7 years}: no (7/1)\n",
       "employment_duration = unemployed: yes (2)\n",
       "employment_duration = < 1 year:\n",
       ":...years_at_residence <= 2: no (4)\n",
       ":   years_at_residence > 2: yes (3)\n",
       "employment_duration = 1 - 4 years:\n",
       ":...months_loan_duration > 21: no (5/1)\n",
       "    months_loan_duration <= 21:\n",
       "    :...job in {skilled,management,unemployed}: yes (5)\n",
       "        job = unskilled: no (1)\n",
       "\n",
       "-----  Trial 1:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "savings_balance in {unknown,100 - 500 DM,500 - 1000 DM,> 1000 DM}:\n",
       ":...employment_duration in {4 - 7 years,> 7 years}:\n",
       ":   :...purpose in {furniture/appliances,business,education}: no (73/4.2)\n",
       ":   :   purpose in {renovations,car0}: yes (4.2/0.8)\n",
       ":   :   purpose = car:\n",
       ":   :   :...checking_balance in {< 0 DM,1 - 200 DM,unknown}: no (37.1/4.2)\n",
       ":   :       checking_balance = > 200 DM: yes (6.1/0.8)\n",
       ":   employment_duration in {1 - 4 years,< 1 year,unemployed}:\n",
       ":   :...existing_loans_count > 1:\n",
       ":       :...months_loan_duration <= 13: no (7.8)\n",
       ":       :   months_loan_duration > 13:\n",
       ":       :   :...housing in {rent,other}: yes (12.1/1.6)\n",
       ":       :       housing = own:\n",
       ":       :       :...percent_of_income <= 1: yes (6.1)\n",
       ":       :           percent_of_income > 1: no (20.9/7.6)\n",
       ":       existing_loans_count <= 1:\n",
       ":       :...savings_balance = > 1000 DM: no (13.1/0.8)\n",
       ":           savings_balance in {unknown,100 - 500 DM,500 - 1000 DM}:\n",
       ":           :...years_at_residence > 3: no (31.9/7.3)\n",
       ":               years_at_residence <= 3:\n",
       ":               :...other_credit = bank: yes (6.8/0.8)\n",
       ":                   other_credit = store: no (1.6/0.8)\n",
       ":                   other_credit = none:\n",
       ":                   :...checking_balance = < 0 DM: yes (5.5/1.6)\n",
       ":                       checking_balance in {unknown,> 200 DM}: no (13.6/2.6)\n",
       ":                       checking_balance = 1 - 200 DM:\n",
       ":                       :...phone = no: no (18.6/6.6)\n",
       ":                           phone = yes: yes (5)\n",
       "savings_balance = < 100 DM:\n",
       ":...amount > 8133: yes (31.8/4.7)\n",
       "    amount <= 8133:\n",
       "    :...months_loan_duration > 33: yes (62.4/19.9)\n",
       "        months_loan_duration <= 33:\n",
       "        :...checking_balance = unknown:\n",
       "            :...age > 23: no (92.6/15.8)\n",
       "            :   age <= 23:\n",
       "            :   :...percent_of_income <= 1: no (3.9)\n",
       "            :       percent_of_income > 1: yes (16.6/0.8)\n",
       "            checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       "            :...credit_history in {very good,perfect}: yes (28.3/8.9)\n",
       "                credit_history = poor: no (12.3/3.9)\n",
       "                credit_history = good:\n",
       "                :...months_loan_duration <= 7: no (10.2)\n",
       "                :   months_loan_duration > 7:\n",
       "                :   :...employment_duration in {4 - 7 years,> 7 years,\n",
       "                :       :                       unemployed}: no (39.2/15.4)\n",
       "                :       employment_duration = 1 - 4 years:\n",
       "                :       :...months_loan_duration <= 9: yes (17.1/3.9)\n",
       "                :       :   months_loan_duration > 9:\n",
       "                :       :   :...months_loan_duration <= 13: no (14.9/2.3)\n",
       "                :       :       months_loan_duration > 13: yes (17.5/6.3)\n",
       "                :       employment_duration = < 1 year:\n",
       "                :       :...percent_of_income <= 1: yes (4.2)\n",
       "                :           percent_of_income > 1:\n",
       "                :           :...years_at_residence <= 1: no (9.4/2.3)\n",
       "                :               years_at_residence > 1: yes (14.7/3.1)\n",
       "                credit_history = critical:\n",
       "                :...years_at_residence <= 1: no (4.7)\n",
       "                    years_at_residence > 1:\n",
       "                    :...years_at_residence <= 2: yes (11.8/2.3)\n",
       "                        years_at_residence > 2:\n",
       "                        :...employment_duration = 1 - 4 years: yes (10/4.7)\n",
       "                            employment_duration in {< 1 year,4 - 7 years,\n",
       "                            :                       unemployed}: no (13.3/0.8)\n",
       "                            employment_duration = > 7 years:\n",
       "                            :...years_at_residence <= 3: yes (6.8)\n",
       "                                years_at_residence > 3: no (15.2/4.2)\n",
       "\n",
       "-----  Trial 2:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance in {< 0 DM,1 - 200 DM}:\n",
       ":...job = unskilled:\n",
       ":   :...age <= 59: no (80.4/22.9)\n",
       ":   :   age > 59: yes (9.7/1.3)\n",
       ":   job in {skilled,management,unemployed}:\n",
       ":   :...savings_balance in {500 - 1000 DM,> 1000 DM}: no (24.8/8.7)\n",
       ":       savings_balance = 100 - 500 DM:\n",
       ":       :...employment_duration in {1 - 4 years,< 1 year}: yes (19.4/2.5)\n",
       ":       :   employment_duration in {4 - 7 years,> 7 years,\n",
       ":       :                           unemployed}: no (17.2/3.8)\n",
       ":       savings_balance = unknown:\n",
       ":       :...existing_loans_count > 1: no (7.5)\n",
       ":       :   existing_loans_count <= 1:\n",
       ":       :   :...years_at_residence <= 3: yes (19.5/7.9)\n",
       ":       :       years_at_residence > 3: no (8.6/1.6)\n",
       ":       savings_balance = < 100 DM:\n",
       ":       :...employment_duration = > 7 years:\n",
       ":           :...existing_loans_count <= 2: yes (46.3/8.9)\n",
       ":           :   existing_loans_count > 2: no (3.5)\n",
       ":           employment_duration = unemployed:\n",
       ":           :...phone = no: yes (11.2/2.8)\n",
       ":           :   phone = yes: no (12.8/2.2)\n",
       ":           employment_duration = < 1 year:\n",
       ":           :...housing = other: no (2.8)\n",
       ":           :   housing in {own,rent}:\n",
       ":           :   :...months_loan_duration <= 8: no (3.5)\n",
       ":           :       months_loan_duration > 8: yes (30.6/6.7)\n",
       ":           employment_duration = 4 - 7 years:\n",
       ":           :...job = unemployed: yes (0)\n",
       ":           :   job = management: no (5)\n",
       ":           :   job = skilled:\n",
       ":           :   :...months_loan_duration <= 21: no (11.7/3.8)\n",
       ":           :       months_loan_duration > 21:\n",
       ":           :       :...dependents <= 1: yes (17.3)\n",
       ":           :           dependents > 1: no (5.3/1.9)\n",
       ":           employment_duration = 1 - 4 years:\n",
       ":           :...months_loan_duration > 39: yes (5.7)\n",
       ":               months_loan_duration <= 39:\n",
       ":               :...housing = other: yes (2.8)\n",
       ":                   housing in {own,rent}:\n",
       ":                   :...percent_of_income > 3:\n",
       ":                       :...age <= 29: no (9.4/3.4)\n",
       ":                       :   age > 29: yes (11.8/0.6)\n",
       ":                       percent_of_income <= 3:\n",
       ":                       :...months_loan_duration > 24: no (12.5)\n",
       ":                           months_loan_duration <= 24:\n",
       ":                           :...job in {skilled,unemployed}: no (26.6/7.5)\n",
       ":                               job = management: yes (4.9/0.6)\n",
       "checking_balance in {unknown,> 200 DM}:\n",
       ":...employment_duration in {4 - 7 years,> 7 years}:\n",
       "    :...credit_history in {good,critical,very good,perfect}: no (104.2/11.4)\n",
       "    :   credit_history = poor: yes (13.7/6)\n",
       "    employment_duration in {1 - 4 years,< 1 year,unemployed}:\n",
       "    :...purpose = business: yes (29.8/8.2)\n",
       "        purpose in {car,furniture/appliances,education,renovations,car0}:\n",
       "        :...credit_history in {very good,poor}: no (9.1/2.1)\n",
       "            credit_history = perfect: yes (5/2.2)\n",
       "            credit_history = critical:\n",
       "            :...savings_balance in {unknown,< 100 DM,> 1000 DM}: no (27)\n",
       "            :   savings_balance in {100 - 500 DM,500 - 1000 DM}: yes (11.5/3.8)\n",
       "            credit_history = good:\n",
       "            :...existing_loans_count > 1: yes (11.1/2.5)\n",
       "                existing_loans_count <= 1:\n",
       "                :...savings_balance in {unknown,100 - 500 DM,\n",
       "                    :                   > 1000 DM}: no (14)\n",
       "                    savings_balance in {< 100 DM,500 - 1000 DM}:\n",
       "                    :...phone = yes: no (17.6/4.3)\n",
       "                        phone = no:\n",
       "                        :...age > 44: no (4.5)\n",
       "                            age <= 44:\n",
       "                            :...amount > 5179: no (3.1)\n",
       "                                amount <= 5179:\n",
       "                                :...job in {management,unskilled,\n",
       "                                    :       unemployed}: yes (12.1/1.9)\n",
       "                                    job = skilled:\n",
       "                                    :...years_at_residence <= 1: no (3.2)\n",
       "                                        years_at_residence > 1: yes (23.3/7.3)\n",
       "\n",
       "-----  Trial 3:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance in {unknown,> 200 DM}:\n",
       ":...other_credit = store: no (12.6/6.1)\n",
       ":   other_credit = none:\n",
       ":   :...credit_history in {critical,perfect}:\n",
       ":   :   :...amount <= 11760: no (72.4/3.3)\n",
       ":   :   :   amount > 11760: yes (4.1)\n",
       ":   :   credit_history in {good,very good,poor}:\n",
       ":   :   :...existing_loans_count <= 1: no (110.4/31.6)\n",
       ":   :       existing_loans_count > 1:\n",
       ":   :       :...employment_duration in {1 - 4 years,< 1 year,> 7 years,\n",
       ":   :           :                       unemployed}: yes (31.7/11.2)\n",
       ":   :           employment_duration = 4 - 7 years: no (9.8)\n",
       ":   other_credit = bank:\n",
       ":   :...employment_duration = > 7 years: no (8.6)\n",
       ":       employment_duration in {1 - 4 years,< 1 year,4 - 7 years,unemployed}:\n",
       ":       :...age > 45: no (3.2)\n",
       ":           age <= 45:\n",
       ":           :...checking_balance = > 200 DM: yes (5.7/0.5)\n",
       ":               checking_balance = unknown:\n",
       ":               :...amount <= 2197: no (4.3)\n",
       ":                   amount > 2197: yes (18/4.8)\n",
       "checking_balance in {< 0 DM,1 - 200 DM}:\n",
       ":...savings_balance in {unknown,> 1000 DM}: no (55.9/16.3)\n",
       "    savings_balance in {< 100 DM,100 - 500 DM,500 - 1000 DM}:\n",
       "    :...months_loan_duration > 47: yes (24/4)\n",
       "        months_loan_duration <= 47:\n",
       "        :...purpose in {business,car0}: no (34.4/11.4)\n",
       "            purpose in {education,renovations}: yes (27.4/9.6)\n",
       "            purpose = car:\n",
       "            :...credit_history in {good,very good,perfect}:\n",
       "            :   :...age <= 22: no (3.8)\n",
       "            :   :   age > 22:\n",
       "            :   :   :...phone = no:\n",
       "            :   :       :...amount <= 5084: yes (35.4/1.9)\n",
       "            :   :       :   amount > 5084: no (3.3)\n",
       "            :   :       phone = yes:\n",
       "            :   :       :...job in {skilled,management}: yes (26.5/10)\n",
       "            :   :           job in {unskilled,unemployed}: no (3.6)\n",
       "            :   credit_history in {critical,poor}:\n",
       "            :   :...other_credit = store: no (0)\n",
       "            :       other_credit = bank: yes (5.3/1.3)\n",
       "            :       other_credit = none:\n",
       "            :       :...existing_loans_count <= 1: no (6.8)\n",
       "            :           existing_loans_count > 1:\n",
       "            :           :...age <= 29: yes (3.6)\n",
       "            :               age > 29: no (19.9/3.1)\n",
       "            purpose = furniture/appliances:\n",
       "            :...savings_balance in {100 - 500 DM,\n",
       "                :                   500 - 1000 DM}: yes (24.9/7.9)\n",
       "                savings_balance = < 100 DM:\n",
       "                :...months_loan_duration <= 16:\n",
       "                    :...existing_loans_count > 1: no (15/1.7)\n",
       "                    :   existing_loans_count <= 1:\n",
       "                    :   :...amount > 6314: yes (2.8)\n",
       "                    :       amount <= 6314:\n",
       "                    :       :...percent_of_income <= 1: yes (8.9/2.6)\n",
       "                    :           percent_of_income > 1: no (38.8/11.2)\n",
       "                    months_loan_duration > 16:\n",
       "                    :...percent_of_income <= 1: no (6.8/1)\n",
       "                        percent_of_income > 1:\n",
       "                        :...dependents > 1: yes (4.5)\n",
       "                            dependents <= 1: [S1]\n",
       "\n",
       "SubTree [S1]\n",
       "\n",
       "employment_duration in {< 1 year,4 - 7 years,unemployed}: yes (35.9/10.6)\n",
       "employment_duration = > 7 years: no (10.8/3.1)\n",
       "employment_duration = 1 - 4 years:\n",
       ":...months_loan_duration <= 21: yes (13.7/1.3)\n",
       "    months_loan_duration > 21: no (7.4/1)\n",
       "\n",
       "-----  Trial 4:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       ":...years_at_residence <= 1: no (77.7/26.8)\n",
       ":   years_at_residence > 1:\n",
       ":   :...percent_of_income <= 2:\n",
       ":       :...credit_history = poor: no (9.1)\n",
       ":       :   credit_history in {good,critical,very good,perfect}:\n",
       ":       :   :...amount > 9283: yes (15.1/1.9)\n",
       ":       :       amount <= 9283:\n",
       ":       :       :...other_credit in {bank,store}: no (14.7/0.8)\n",
       ":       :           other_credit = none:\n",
       ":       :           :...savings_balance = 100 - 500 DM: yes (13.3/4)\n",
       ":       :               savings_balance in {unknown,500 - 1000 DM,\n",
       ":       :               :                   > 1000 DM}: no (16.2/1.1)\n",
       ":       :               savings_balance = < 100 DM:\n",
       ":       :               :...purpose in {car,education,renovations,\n",
       ":       :                   :           car0}: no (25.5/6.5)\n",
       ":       :                   purpose = business: yes (4.2/0.4)\n",
       ":       :                   purpose = furniture/appliances:\n",
       ":       :                   :...dependents <= 1: yes (27.1/11.4)\n",
       ":       :                       dependents > 1: no (5.9/1.1)\n",
       ":       percent_of_income > 2:\n",
       ":       :...credit_history = perfect: yes (6.8/1.3)\n",
       ":           credit_history = very good:\n",
       ":           :...age <= 23: no (3.6)\n",
       ":           :   age > 23: yes (21.2/3.9)\n",
       ":           credit_history = poor:\n",
       ":           :...savings_balance in {unknown,100 - 500 DM}: no (5.2)\n",
       ":           :   savings_balance in {< 100 DM,500 - 1000 DM,\n",
       ":           :                       > 1000 DM}: yes (16/1.4)\n",
       ":           credit_history = critical:\n",
       ":           :...existing_loans_count > 2: no (3.2)\n",
       ":           :   existing_loans_count <= 2:\n",
       ":           :   :...dependents > 1: yes (5.6/1.1)\n",
       ":           :       dependents <= 1:\n",
       ":           :       :...purpose in {car,furniture/appliances,education,\n",
       ":           :           :           renovations,car0}: no (45.8/16)\n",
       ":           :           purpose = business: yes (4/0.4)\n",
       ":           credit_history = good:\n",
       ":           :...amount > 6361: yes (11.6)\n",
       ":               amount <= 6361:\n",
       ":               :...job in {management,unemployed}: no (14.5/3.1)\n",
       ":                   job in {skilled,unskilled}:\n",
       ":                   :...employment_duration in {< 1 year,4 - 7 years,\n",
       ":                       :                       unemployed}: yes (38.5/12)\n",
       ":                       employment_duration = > 7 years:\n",
       ":                       :...other_credit in {none,store}: no (17.8/4.3)\n",
       ":                       :   other_credit = bank: yes (9.8/2.4)\n",
       ":                       employment_duration = 1 - 4 years:\n",
       ":                       :...months_loan_duration > 24: yes (9.9)\n",
       ":                           months_loan_duration <= 24:\n",
       ":                           :...amount <= 1864: yes (37.1/11.2)\n",
       ":                               amount > 1864: no (14.2/2.8)\n",
       "checking_balance = unknown:\n",
       ":...employment_duration = unemployed: yes (14.7/5.8)\n",
       "    employment_duration = 4 - 7 years:\n",
       "    :...age <= 22: yes (8.8/2.7)\n",
       "    :   age > 22: no (26.3)\n",
       "    employment_duration = > 7 years:\n",
       "    :...amount <= 11054: no (39.6/3.7)\n",
       "    :   amount > 11054: yes (3.8/0.4)\n",
       "    employment_duration = < 1 year:\n",
       "    :...months_loan_duration > 30: yes (2.8)\n",
       "    :   months_loan_duration <= 30:\n",
       "    :   :...housing in {rent,other}: no (7.7/1.4)\n",
       "    :       housing = own:\n",
       "    :       :...amount <= 4530: no (16.3/6)\n",
       "    :           amount > 4530: yes (6.4)\n",
       "    employment_duration = 1 - 4 years:\n",
       "    :...dependents > 1: no (12.1)\n",
       "        dependents <= 1:\n",
       "        :...amount <= 1382: no (15.3)\n",
       "            amount > 1382:\n",
       "            :...percent_of_income <= 1: no (13/1.4)\n",
       "                percent_of_income > 1:\n",
       "                :...other_credit in {bank,store}: yes (11.7/1.5)\n",
       "                    other_credit = none:\n",
       "                    :...years_at_residence > 3: no (11/1.4)\n",
       "                        years_at_residence <= 3:\n",
       "                        :...job in {management,unemployed}: yes (10.6/2.3)\n",
       "                            job = unskilled: no (1.5)\n",
       "                            job = skilled:\n",
       "                            :...purpose in {car,business,education,\n",
       "                                :           car0}: yes (18.3/5.2)\n",
       "                                purpose in {furniture/appliances,\n",
       "                                            renovations}: no (6.4)\n",
       "\n",
       "-----  Trial 5:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance = unknown:\n",
       ":...employment_duration in {4 - 7 years,unemployed}: no (50.3/12.2)\n",
       ":   employment_duration = > 7 years:\n",
       ":   :...credit_history in {good,critical,very good,perfect}: no (31.4/2.8)\n",
       ":   :   credit_history = poor: yes (7/1.8)\n",
       ":   employment_duration = < 1 year:\n",
       ":   :...amount <= 1512: no (4.4)\n",
       ":   :   amount > 1512:\n",
       ":   :   :...purpose in {car,education}: no (4.8)\n",
       ":   :       purpose in {furniture/appliances,business,renovations,\n",
       ":   :                   car0}: yes (21.5/4.4)\n",
       ":   employment_duration = 1 - 4 years:\n",
       ":   :...amount <= 1382: no (12.9)\n",
       ":       amount > 1382:\n",
       ":       :...age > 52: yes (4)\n",
       ":           age <= 52:\n",
       ":           :...other_credit in {bank,store}: yes (18.3/7.9)\n",
       ":               other_credit = none:\n",
       ":               :...age > 30: no (27.4)\n",
       ":                   age <= 30:\n",
       ":                   :...years_at_residence > 3: no (2.5)\n",
       ":                       years_at_residence <= 3:\n",
       ":                       :...amount > 4530: no (5.5)\n",
       ":                           amount <= 4530:\n",
       ":                           :...months_loan_duration <= 9: no (3.1)\n",
       ":                               months_loan_duration > 9: yes (21.1/5.6)\n",
       "checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       ":...savings_balance = > 1000 DM: no (13.4/5)\n",
       "    savings_balance = 500 - 1000 DM:\n",
       "    :...amount <= 3249: no (14.8/1.9)\n",
       "    :   amount > 3249: yes (7.2/1)\n",
       "    savings_balance = unknown:\n",
       "    :...years_at_residence > 3: no (15.9/2.5)\n",
       "    :   years_at_residence <= 3:\n",
       "    :   :...amount <= 1345: yes (7.3)\n",
       "    :       amount > 1345:\n",
       "    :       :...amount <= 11760: no (22.9/7.4)\n",
       "    :           amount > 11760: yes (2)\n",
       "    savings_balance = 100 - 500 DM:\n",
       "    :...percent_of_income <= 1: yes (8/0.7)\n",
       "    :   percent_of_income > 1:\n",
       "    :   :...phone = yes: no (17.5/2.4)\n",
       "    :       phone = no:\n",
       "    :       :...existing_loans_count > 1: yes (4.9/0.3)\n",
       "    :           existing_loans_count <= 1:\n",
       "    :           :...age <= 24: yes (9.6/1.2)\n",
       "    :               age > 24: no (14.3/2.6)\n",
       "    savings_balance = < 100 DM:\n",
       "    :...months_loan_duration <= 7: no (19.5/2.7)\n",
       "        months_loan_duration > 7:\n",
       "        :...job = management: no (51.6/23)\n",
       "            job = unemployed: yes (7.4/0.7)\n",
       "            job = unskilled:\n",
       "            :...dependents > 1: yes (14.2/3.7)\n",
       "            :   dependents <= 1:\n",
       "            :   :...months_loan_duration > 27: yes (9.1/1.7)\n",
       "            :       months_loan_duration <= 27:\n",
       "            :       :...checking_balance in {< 0 DM,1 - 200 DM}: no (53.5/17.1)\n",
       "            :           checking_balance = > 200 DM: yes (4.2/1.2)\n",
       "            job = skilled:\n",
       "            :...checking_balance = > 200 DM:\n",
       "                :...other_credit in {none,bank}: no (17.9/3.6)\n",
       "                :   other_credit = store: yes (2)\n",
       "                checking_balance in {< 0 DM,1 - 200 DM}:\n",
       "                :...housing = other: yes (16.1/2.1)\n",
       "                    housing in {own,rent}:\n",
       "                    :...dependents > 1:\n",
       "                        :...checking_balance = < 0 DM: no (12.8/2.4)\n",
       "                        :   checking_balance = 1 - 200 DM: yes (6.6/0.9)\n",
       "                        dependents <= 1:\n",
       "                        :...purpose in {business,education}: yes (16.4/5.5)\n",
       "                            purpose in {renovations,car0}: no (4.1/1.8)\n",
       "                            purpose = car:\n",
       "                            :...years_at_residence > 3: no (8.8/3)\n",
       "                            :   years_at_residence <= 3:\n",
       "                            :   :...amount <= 5433: yes (19.6/1.2)\n",
       "                            :       amount > 5433: no (2.7)\n",
       "                            purpose = furniture/appliances:\n",
       "                            :...months_loan_duration > 33: yes (9.8/0.9)\n",
       "                                months_loan_duration <= 33:\n",
       "                                :...existing_loans_count <= 1: [S1]\n",
       "                                    existing_loans_count > 1:\n",
       "                                    :...age <= 54: no (17.9/4)\n",
       "                                        age > 54: yes (3.2)\n",
       "\n",
       "SubTree [S1]\n",
       "\n",
       "employment_duration in {1 - 4 years,< 1 year,4 - 7 years,\n",
       ":                       unemployed}: yes (46/15.7)\n",
       "employment_duration = > 7 years: no (4.6)\n",
       "\n",
       "-----  Trial 6:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance = unknown:\n",
       ":...age <= 22: yes (19.1/6.3)\n",
       ":   age > 22:\n",
       ":   :...employment_duration = 4 - 7 years: no (17.6)\n",
       ":       employment_duration in {1 - 4 years,< 1 year,> 7 years,unemployed}:\n",
       ":       :...amount <= 1382: no (22.6)\n",
       ":           amount > 1382:\n",
       ":           :...purpose in {car,education,car0}: no (58.1/18.6)\n",
       ":               purpose = renovations: yes (7/2.6)\n",
       ":               purpose = furniture/appliances:\n",
       ":               :...job in {skilled,unemployed}: no (37.2/3.3)\n",
       ":               :   job in {management,unskilled}: yes (16.8/5.8)\n",
       ":               purpose = business:\n",
       ":               :...employment_duration in {1 - 4 years,\n",
       ":                   :                       > 7 years}: no (16.2/4.8)\n",
       ":                   employment_duration in {< 1 year,unemployed}: yes (8.4)\n",
       "checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       ":...percent_of_income <= 3:\n",
       "    :...amount > 11760: yes (17.6/2.1)\n",
       "    :   amount <= 11760:\n",
       "    :   :...other_credit = store: yes (6.1/0.7)\n",
       "    :       other_credit in {none,bank}:\n",
       "    :       :...months_loan_duration <= 7: no (19.1/1.9)\n",
       "    :           months_loan_duration > 7:\n",
       "    :           :...purpose in {business,education,renovations,\n",
       "    :               :           car0}: no (39.9/10.7)\n",
       "    :               purpose = furniture/appliances:\n",
       "    :               :...months_loan_duration > 36: yes (8.4/1)\n",
       "    :               :   months_loan_duration <= 36:\n",
       "    :               :   :...amount <= 6361: no (91/34)\n",
       "    :               :       amount > 6361: yes (5.5)\n",
       "    :               purpose = car:\n",
       "    :               :...amount <= 1413: yes (13.8/1.1)\n",
       "    :                   amount > 1413:\n",
       "    :                   :...other_credit = bank: no (11.9/1.9)\n",
       "    :                       other_credit = none:\n",
       "    :                       :...percent_of_income <= 2: no (25.2/7)\n",
       "    :                           percent_of_income > 2: yes (17/4.9)\n",
       "    percent_of_income > 3:\n",
       "    :...years_at_residence <= 1: no (37.8/14.8)\n",
       "        years_at_residence > 1:\n",
       "        :...months_loan_duration <= 11:\n",
       "            :...credit_history in {good,critical,poor}: no (25.4/4.4)\n",
       "            :   credit_history in {very good,perfect}: yes (6.9/0.7)\n",
       "            months_loan_duration > 11:\n",
       "            :...savings_balance = > 1000 DM: no (3.6)\n",
       "                savings_balance in {unknown,< 100 DM,100 - 500 DM,\n",
       "                :                   500 - 1000 DM}:\n",
       "                :...credit_history in {very good,perfect}: yes (18.8/2.7)\n",
       "                    credit_history = poor: no (10.4/5.1)\n",
       "                    credit_history = critical:\n",
       "                    :...age <= 23: no (4.2)\n",
       "                    :   age > 23:\n",
       "                    :   :...months_loan_duration <= 16: no (7.2/1.6)\n",
       "                    :       months_loan_duration > 16: yes (30.3/6)\n",
       "                    credit_history = good:\n",
       "                    :...employment_duration = < 1 year: yes (10.6)\n",
       "                        employment_duration in {1 - 4 years,4 - 7 years,\n",
       "                        :                       > 7 years,unemployed}:\n",
       "                        :...years_at_residence <= 2: yes (37.1/6.8)\n",
       "                            years_at_residence > 2:\n",
       "                            :...amount > 5965: yes (7.2)\n",
       "                                amount <= 5965: [S1]\n",
       "\n",
       "SubTree [S1]\n",
       "\n",
       "savings_balance = unknown: no (4.1)\n",
       "savings_balance = 500 - 1000 DM: yes (2.6)\n",
       "savings_balance in {< 100 DM,100 - 500 DM}:\n",
       ":...amount > 3931: no (6.5)\n",
       "    amount <= 3931:\n",
       "    :...dependents > 1: yes (8.7/0.9)\n",
       "        dependents <= 1:\n",
       "        :...employment_duration in {1 - 4 years,4 - 7 years}: yes (15.2/5.5)\n",
       "            employment_duration in {> 7 years,unemployed}: no (5.2)\n",
       "\n",
       "-----  Trial 7:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance = unknown:\n",
       ":...purpose in {education,renovations,car0}: no (22.5/9.9)\n",
       ":   purpose = business:\n",
       ":   :...dependents > 1: no (2.6)\n",
       ":   :   dependents <= 1:\n",
       ":   :   :...phone = no: no (9.9/2.5)\n",
       ":   :       phone = yes: yes (14.4/2.9)\n",
       ":   purpose = car:\n",
       ":   :...employment_duration in {< 1 year,4 - 7 years,unemployed}: no (13.2)\n",
       ":   :   employment_duration in {1 - 4 years,> 7 years}:\n",
       ":   :   :...years_at_residence <= 2:\n",
       ":   :       :...savings_balance in {unknown,< 100 DM,100 - 500 DM,\n",
       ":   :       :   :                   > 1000 DM}: no (16.4)\n",
       ":   :       :   savings_balance = 500 - 1000 DM: yes (5.4/0.6)\n",
       ":   :       years_at_residence > 2:\n",
       ":   :       :...months_loan_duration <= 16: no (4.3)\n",
       ":   :           months_loan_duration > 16: yes (21.2/5.6)\n",
       ":   purpose = furniture/appliances:\n",
       ":   :...credit_history in {critical,very good,perfect}: no (24.7)\n",
       ":       credit_history in {good,poor}:\n",
       ":       :...savings_balance in {unknown,100 - 500 DM,500 - 1000 DM,\n",
       ":           :                   > 1000 DM}: no (20.2/1.7)\n",
       ":           savings_balance = < 100 DM:\n",
       ":           :...housing = other: no (3.9)\n",
       ":               housing in {own,rent}:\n",
       ":               :...months_loan_duration > 48: no (2.9)\n",
       ":                   months_loan_duration <= 48:\n",
       ":                   :...other_credit in {bank,store}: no (5.7/1.2)\n",
       ":                       other_credit = none:\n",
       ":                       :...job in {management,unskilled,\n",
       ":                           :       unemployed}: yes (9/1.3)\n",
       ":                           job = skilled: [S1]\n",
       "checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       ":...credit_history = perfect: yes (26.5/7.9)\n",
       "    credit_history = very good:\n",
       "    :...age <= 23: no (5.2)\n",
       "    :   age > 23:\n",
       "    :   :...amount <= 8471: yes (35.8/5.9)\n",
       "    :       amount > 8471: no (2.8)\n",
       "    credit_history = poor:\n",
       "    :...savings_balance = 500 - 1000 DM: yes (0)\n",
       "    :   savings_balance in {unknown,100 - 500 DM}: no (9.2)\n",
       "    :   savings_balance in {< 100 DM,> 1000 DM}:\n",
       "    :   :...job in {skilled,management,unemployed}: yes (22.9/2.6)\n",
       "    :       job = unskilled: no (3.2)\n",
       "    credit_history = good:\n",
       "    :...purpose in {business,car0}: no (21.1/3.8)\n",
       "    :   purpose in {car,furniture/appliances,education,renovations}:\n",
       "    :   :...amount > 8648: yes (15.3/1.3)\n",
       "    :       amount <= 8648:\n",
       "    :       :...other_credit = bank: no (24.7/8.9)\n",
       "    :           other_credit = store: yes (5.5/2.1)\n",
       "    :           other_credit = none:\n",
       "    :           :...checking_balance = > 200 DM:\n",
       "    :               :...dependents <= 1: no (19.9/6.3)\n",
       "    :               :   dependents > 1: yes (4.6/0.2)\n",
       "    :               checking_balance = < 0 DM:\n",
       "    :               :...employment_duration in {< 1 year,\n",
       "    :               :   :                       > 7 years}: yes (31/7.3)\n",
       "    :               :   employment_duration = unemployed: no (7.3/2.8)\n",
       "    :               :   employment_duration = 4 - 7 years:\n",
       "    :               :   :...dependents <= 1: yes (18.3/4.9)\n",
       "    :               :   :   dependents > 1: no (5.1/0.6)\n",
       "    :               :   employment_duration = 1 - 4 years:\n",
       "    :               :   :...purpose in {car,education,\n",
       "    :               :       :           renovations}: yes (13/2.6)\n",
       "    :               :       purpose = furniture/appliances:\n",
       "    :               :       :...months_loan_duration <= 13: no (8.9)\n",
       "    :               :           months_loan_duration > 13: yes (17/3.9)\n",
       "    :               checking_balance = 1 - 200 DM:\n",
       "    :               :...job in {unskilled,unemployed}: no (21.6/2.2)\n",
       "    :                   job in {skilled,management}:\n",
       "    :                   :...housing = rent: yes (19.3/4)\n",
       "    :                       housing = other: no (2.7/1.3)\n",
       "    :                       housing = own:\n",
       "    :                       :...existing_loans_count <= 1: yes (42.6/18.4)\n",
       "    :                           existing_loans_count > 1: no (8.1/0.2)\n",
       "    credit_history = critical:\n",
       "    :...years_at_residence <= 1: no (5.8)\n",
       "        years_at_residence > 1:\n",
       "        :...savings_balance in {unknown,100 - 500 DM,500 - 1000 DM,\n",
       "            :                   > 1000 DM}: no (19.6/4.1)\n",
       "            savings_balance = < 100 DM:\n",
       "            :...checking_balance = > 200 DM: no (3.5)\n",
       "                checking_balance in {< 0 DM,1 - 200 DM}:\n",
       "                :...age > 62: no (4.2)\n",
       "                    age <= 62:\n",
       "                    :...age > 52: yes (10/0.2)\n",
       "                        age <= 52:\n",
       "                        :...existing_loans_count > 2: no (6)\n",
       "                            existing_loans_count <= 2:\n",
       "                            :...other_credit = bank: yes (3.5/1.3)\n",
       "                                other_credit = store: no (1.6)\n",
       "                                other_credit = none:\n",
       "                                :...job in {management,\n",
       "                                    :       unemployed}: yes (12.6/0.6)\n",
       "                                    job in {skilled,unskilled}:\n",
       "                                    :...dependents > 1: no (2.7)\n",
       "                                        dependents <= 1:\n",
       "                                        :...years_at_residence <= 2: yes (11.7/2.8)\n",
       "                                            years_at_residence > 2: [S2]\n",
       "\n",
       "SubTree [S1]\n",
       "\n",
       "employment_duration in {1 - 4 years,> 7 years}: no (8.7)\n",
       "employment_duration in {< 1 year,4 - 7 years,unemployed}: yes (17.2/5)\n",
       "\n",
       "SubTree [S2]\n",
       "\n",
       "percent_of_income <= 3: no (9.1)\n",
       "percent_of_income > 3: yes (16/6.1)\n",
       "\n",
       "-----  Trial 8:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance = unknown:\n",
       ":...purpose in {car,furniture/appliances,car0}: no (150.5/37)\n",
       ":   purpose in {education,renovations}: yes (21.8/9.1)\n",
       ":   purpose = business:\n",
       ":   :...dependents > 1: no (2.1)\n",
       ":       dependents <= 1:\n",
       ":       :...amount <= 2058: no (6.6)\n",
       ":           amount > 2058:\n",
       ":           :...savings_balance in {unknown,< 100 DM,500 - 1000 DM,\n",
       ":               :                   > 1000 DM}: yes (16.7/3.5)\n",
       ":               savings_balance = 100 - 500 DM: no (3)\n",
       "checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       ":...dependents > 1:\n",
       "    :...other_credit = bank: yes (20.2/3.4)\n",
       "    :   other_credit in {none,store}:\n",
       "    :   :...months_loan_duration <= 9: no (6.8)\n",
       "    :       months_loan_duration > 9:\n",
       "    :       :...housing in {rent,other}: yes (14.5/2.9)\n",
       "    :           housing = own:\n",
       "    :           :...months_loan_duration > 28: no (7.8)\n",
       "    :               months_loan_duration <= 28:\n",
       "    :               :...years_at_residence <= 3: yes (18.4/5.8)\n",
       "    :                   years_at_residence > 3: no (3.6)\n",
       "    dependents <= 1:\n",
       "    :...savings_balance in {unknown,> 1000 DM}: no (55.2/16.7)\n",
       "        savings_balance = 500 - 1000 DM:\n",
       "        :...amount <= 3931: no (14.9/2.8)\n",
       "        :   amount > 3931: yes (4.5)\n",
       "        savings_balance = 100 - 500 DM:\n",
       "        :...age <= 22: yes (5.5)\n",
       "        :   age > 22:\n",
       "        :   :...job in {skilled,unemployed}: no (24.2/7)\n",
       "        :       job in {management,unskilled}: yes (11.3/3.2)\n",
       "        savings_balance = < 100 DM:\n",
       "        :...job = unemployed: yes (7.7/1.5)\n",
       "            job = unskilled:\n",
       "            :...years_at_residence <= 1: no (9.8/1)\n",
       "            :   years_at_residence > 1:\n",
       "            :   :...employment_duration in {1 - 4 years,4 - 7 years,> 7 years,\n",
       "            :       :                       unemployed}: no (51.8/18.9)\n",
       "            :       employment_duration = < 1 year: yes (11.8/1.6)\n",
       "            job = management:\n",
       "            :...years_at_residence <= 1: no (5.6)\n",
       "            :   years_at_residence > 1:\n",
       "            :   :...credit_history in {critical,poor,perfect}: yes (21.8/4.9)\n",
       "            :       credit_history = very good: no (3.5)\n",
       "            :       credit_history = good:\n",
       "            :       :...housing = own: no (7.2/1.3)\n",
       "            :           housing in {rent,other}: yes (14.4/4)\n",
       "            job = skilled:\n",
       "            :...credit_history = very good: yes (8.2/0.5)\n",
       "                credit_history in {good,critical,poor,perfect}:\n",
       "                :...purpose in {business,car0}: no (15.4/4.6)\n",
       "                    purpose in {education,renovations}: yes (10.3/3.3)\n",
       "                    purpose = car:\n",
       "                    :...other_credit in {bank,store}: yes (3.4)\n",
       "                    :   other_credit = none:\n",
       "                    :   :...checking_balance in {1 - 200 DM,\n",
       "                    :       :                    > 200 DM}: no (10.6/1.9)\n",
       "                    :       checking_balance = < 0 DM:\n",
       "                    :       :...age <= 47: yes (19.4/4.2)\n",
       "                    :           age > 47: no (2.8)\n",
       "                    purpose = furniture/appliances:\n",
       "                    :...months_loan_duration <= 7: no (6.9)\n",
       "                        months_loan_duration > 7:\n",
       "                        :...months_loan_duration > 33: yes (12.9/3.5)\n",
       "                            months_loan_duration <= 33:\n",
       "                            :...employment_duration in {4 - 7 years,\n",
       "                                :                       > 7 years}: no (22.5/4.6)\n",
       "                                employment_duration = unemployed: yes (1.3)\n",
       "                                employment_duration = < 1 year:\n",
       "                                :...phone = yes: yes (4.1)\n",
       "                                :   phone = no:\n",
       "                                :   :...percent_of_income <= 1: yes (3.3)\n",
       "                                :       percent_of_income > 1: no (18.5/3.3)\n",
       "                                employment_duration = 1 - 4 years:\n",
       "                                :...credit_history in {poor,\n",
       "                                    :                  perfect}: no (3.2)\n",
       "                                    credit_history in {good,critical}:\n",
       "                                    :...months_loan_duration > 16: yes (13.2/2)\n",
       "                                        months_loan_duration <= 16: [S1]\n",
       "\n",
       "SubTree [S1]\n",
       "\n",
       "months_loan_duration <= 9: yes (11.1/3.9)\n",
       "months_loan_duration > 9: no (12.1)\n",
       "\n",
       "-----  Trial 9:  -----\n",
       "\n",
       "Decision tree:\n",
       "\n",
       "checking_balance = unknown:\n",
       ":...credit_history in {critical,very good,perfect}: no (62.2/9.1)\n",
       ":   credit_history = poor:\n",
       ":   :...age <= 30: yes (14.4/5.6)\n",
       ":   :   age > 30: no (11.4/1.8)\n",
       ":   credit_history = good:\n",
       ":   :...employment_duration in {4 - 7 years,> 7 years}: no (31/3.2)\n",
       ":       employment_duration = unemployed: yes (7.3/1.6)\n",
       ":       employment_duration = < 1 year:\n",
       ":       :...amount <= 4210: no (19.2/7.4)\n",
       ":       :   amount > 4210: yes (7.2/0.7)\n",
       ":       employment_duration = 1 - 4 years:\n",
       ":       :...other_credit = store: yes (3.2)\n",
       ":           other_credit in {none,bank}:\n",
       ":           :...housing = other: no (6)\n",
       ":               housing in {own,rent}:\n",
       ":               :...percent_of_income <= 1: no (3.5)\n",
       ":                   percent_of_income > 1:\n",
       ":                   :...other_credit = bank: yes (5.1/0.4)\n",
       ":                       other_credit = none:\n",
       ":                       :...existing_loans_count <= 1: no (20.2/7.5)\n",
       ":                           existing_loans_count > 1: yes (5.1/0.8)\n",
       "checking_balance in {< 0 DM,1 - 200 DM,> 200 DM}:\n",
       ":...credit_history = very good:\n",
       "    :...age <= 23: no (4.3)\n",
       "    :   age > 23: yes (34/9.1)\n",
       "    credit_history = perfect:\n",
       "    :...age <= 33: no (17.3/6.7)\n",
       "    :   age > 33: yes (9.4)\n",
       "    credit_history = critical:\n",
       "    :...existing_loans_count > 2: no (12.7/1.5)\n",
       "    :   existing_loans_count <= 2:\n",
       "    :   :...savings_balance in {unknown,100 - 500 DM,> 1000 DM}: no (11.3/2.7)\n",
       "    :       savings_balance = 500 - 1000 DM: yes (4.2/1.7)\n",
       "    :       savings_balance = < 100 DM:\n",
       "    :       :...amount <= 7865: no (69.2/28.4)\n",
       "    :           amount > 7865: yes (4)\n",
       "    credit_history = poor:\n",
       "    :...savings_balance in {unknown,100 - 500 DM,500 - 1000 DM}: no (8.6)\n",
       "    :   savings_balance in {< 100 DM,> 1000 DM}:\n",
       "    :   :...job = unemployed: yes (0)\n",
       "    :       job = unskilled: no (3.2)\n",
       "    :       job in {skilled,management}:\n",
       "    :       :...percent_of_income <= 2: no (7.5/1.5)\n",
       "    :           percent_of_income > 2: yes (15.1)\n",
       "    credit_history = good:\n",
       "    :...purpose in {education,renovations,car0}: no (16.7/4.6)\n",
       "        purpose = business:\n",
       "        :...amount <= 2679: no (10.8)\n",
       "        :   amount > 2679: yes (8.6/1.4)\n",
       "        purpose = car:\n",
       "        :...phone = yes:\n",
       "        :   :...amount <= 11054: no (36.5/9.6)\n",
       "        :   :   amount > 11054: yes (9)\n",
       "        :   phone = no:\n",
       "        :   :...amount <= 1459: yes (29.3/2.3)\n",
       "        :       amount > 1459:\n",
       "        :       :...percent_of_income <= 2: no (6.3)\n",
       "        :           percent_of_income > 2: yes (16.3/6)\n",
       "        purpose = furniture/appliances:\n",
       "        :...months_loan_duration <= 7: no (10.8)\n",
       "            months_loan_duration > 7:\n",
       "            :...savings_balance in {unknown,100 - 500 DM}: yes (29.8/10.7)\n",
       "                savings_balance in {500 - 1000 DM,> 1000 DM}: no (11.7/3.6)\n",
       "                savings_balance = < 100 DM:\n",
       "                :...phone = yes:\n",
       "                    :...employment_duration in {1 - 4 years,\n",
       "                    :   :                       unemployed}: no (11.7/4.1)\n",
       "                    :   employment_duration in {< 1 year,4 - 7 years,\n",
       "                    :                           > 7 years}: yes (10.6)\n",
       "                    phone = no:\n",
       "                    :...dependents > 1: yes (13.1/4.5)\n",
       "                        dependents <= 1:\n",
       "                        :...job = management: no (3.4)\n",
       "                            job = unemployed: yes (2.4)\n",
       "                            job in {skilled,unskilled}:\n",
       "                            :...months_loan_duration <= 9: yes (19.7/7.2)\n",
       "                                months_loan_duration > 9: no (53.7/15.2)\n",
       "\n",
       "\n",
       "Evaluation on training data (700 cases):\n",
       "\n",
       "Trial\t    Decision Tree   \n",
       "-----\t  ----------------  \n",
       "\t  Size      Errors  \n",
       "\n",
       "   0\t    50   82(11.7%)\n",
       "   1\t    37  135(19.3%)\n",
       "   2\t    41  147(21.0%)\n",
       "   3\t    35  128(18.3%)\n",
       "   4\t    45  139(19.9%)\n",
       "   5\t    48  130(18.6%)\n",
       "   6\t    38  129(18.4%)\n",
       "   7\t    55  156(22.3%)\n",
       "   8\t    45  133(19.0%)\n",
       "   9\t    44  134(19.1%)\n",
       "boost\t         14( 2.0%)   <<\n",
       "\n",
       "\n",
       "\t   (a)   (b)    <-classified as\n",
       "\t  ----  ----\n",
       "\t   494     2    (a): class no\n",
       "\t    12   192    (b): class yes\n",
       "\n",
       "\n",
       "\tAttribute usage:\n",
       "\n",
       "\t100.00%\tchecking_balance\n",
       "\t100.00%\tcredit_history\n",
       "\t100.00%\tsavings_balance\n",
       "\t 99.29%\tpurpose\n",
       "\t 98.86%\temployment_duration\n",
       "\t 96.71%\tamount\n",
       "\t 92.86%\tother_credit\n",
       "\t 88.29%\tmonths_loan_duration\n",
       "\t 78.43%\tage\n",
       "\t 77.57%\tyears_at_residence\n",
       "\t 77.57%\tdependents\n",
       "\t 75.14%\tpercent_of_income\n",
       "\t 74.43%\tjob\n",
       "\t 69.00%\texisting_loans_count\n",
       "\t 52.00%\thousing\n",
       "\t 43.29%\tphone\n",
       "\n",
       "\n",
       "Time: 0.0 secs\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "## Boosting the accuracy of decision trees\n",
    "# boosted decision tree with 10 trials\n",
    "credit_boost10 <- C5.0(credit_train[-17], credit_train$default,\n",
    "                       trials = 10)\n",
    "credit_boost10\n",
    "summary(credit_boost10)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "eeabd575",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:14:12.239978Z",
     "iopub.status.busy": "2022-01-23T13:14:12.237981Z",
     "iopub.status.idle": "2022-01-23T13:14:12.284337Z",
     "shell.execute_reply": "2022-01-23T13:14:12.282736Z"
    },
    "papermill": {
     "duration": 0.200526,
     "end_time": "2022-01-23T13:14:12.284555",
     "exception": false,
     "start_time": "2022-01-23T13:14:12.084029",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " \n",
      "   Cell Contents\n",
      "|-------------------------|\n",
      "|                       N |\n",
      "|         N / Table Total |\n",
      "|-------------------------|\n",
      "\n",
      " \n",
      "Total Observations in Table:  300 \n",
      "\n",
      " \n",
      "               | predicted default \n",
      "actual default |        no |       yes | Row Total | \n",
      "---------------|-----------|-----------|-----------|\n",
      "            no |       176 |        28 |       204 | \n",
      "               |     0.587 |     0.093 |           | \n",
      "---------------|-----------|-----------|-----------|\n",
      "           yes |        56 |        40 |        96 | \n",
      "               |     0.187 |     0.133 |           | \n",
      "---------------|-----------|-----------|-----------|\n",
      "  Column Total |       232 |        68 |       300 | \n",
      "---------------|-----------|-----------|-----------|\n",
      "\n",
      " \n"
     ]
    }
   ],
   "source": [
    "credit_boost_pred10 <- predict(credit_boost10, credit_test)\n",
    "CrossTable(credit_test$default, credit_boost_pred10,\n",
    "           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,\n",
    "           dnn = c('actual default', 'predicted default'))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "3ebede35",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:14:12.592247Z",
     "iopub.status.busy": "2022-01-23T13:14:12.589594Z",
     "iopub.status.idle": "2022-01-23T13:14:12.648106Z",
     "shell.execute_reply": "2022-01-23T13:14:12.645825Z"
    },
    "papermill": {
     "duration": 0.214104,
     "end_time": "2022-01-23T13:14:12.648299",
     "exception": false,
     "start_time": "2022-01-23T13:14:12.434195",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<dl>\n",
       "\t<dt>$predicted</dt>\n",
       "\t\t<dd><style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'no'</li><li>'yes'</li></ol>\n",
       "</dd>\n",
       "\t<dt>$actual</dt>\n",
       "\t\t<dd><style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'no'</li><li>'yes'</li></ol>\n",
       "</dd>\n",
       "</dl>\n"
      ],
      "text/latex": [
       "\\begin{description}\n",
       "\\item[\\$predicted] \\begin{enumerate*}\n",
       "\\item 'no'\n",
       "\\item 'yes'\n",
       "\\end{enumerate*}\n",
       "\n",
       "\\item[\\$actual] \\begin{enumerate*}\n",
       "\\item 'no'\n",
       "\\item 'yes'\n",
       "\\end{enumerate*}\n",
       "\n",
       "\\end{description}\n"
      ],
      "text/markdown": [
       "$predicted\n",
       ":   1. 'no'\n",
       "2. 'yes'\n",
       "\n",
       "\n",
       "\n",
       "$actual\n",
       ":   1. 'no'\n",
       "2. 'yes'\n",
       "\n",
       "\n",
       "\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       "$predicted\n",
       "[1] \"no\"  \"yes\"\n",
       "\n",
       "$actual\n",
       "[1] \"no\"  \"yes\"\n"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# creating dimensions for a cost matrix\n",
    "matrix_dimensions <- list(c(\"no\", \"yes\"), c(\"no\", \"yes\"))\n",
    "names(matrix_dimensions) <- c(\"predicted\", \"actual\")\n",
    "matrix_dimensions"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "6aaa22ba",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:14:12.966360Z",
     "iopub.status.busy": "2022-01-23T13:14:12.963803Z",
     "iopub.status.idle": "2022-01-23T13:14:12.996382Z",
     "shell.execute_reply": "2022-01-23T13:14:12.993991Z"
    },
    "papermill": {
     "duration": 0.192757,
     "end_time": "2022-01-23T13:14:12.996579",
     "exception": false,
     "start_time": "2022-01-23T13:14:12.803822",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A matrix: 2 × 2 of type dbl</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>no</th><th scope=col>yes</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>no</th><td>0</td><td>4</td></tr>\n",
       "\t<tr><th scope=row>yes</th><td>1</td><td>0</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A matrix: 2 × 2 of type dbl\n",
       "\\begin{tabular}{r|ll}\n",
       "  & no & yes\\\\\n",
       "\\hline\n",
       "\tno & 0 & 4\\\\\n",
       "\tyes & 1 & 0\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A matrix: 2 × 2 of type dbl\n",
       "\n",
       "| <!--/--> | no | yes |\n",
       "|---|---|---|\n",
       "| no | 0 | 4 |\n",
       "| yes | 1 | 0 |\n",
       "\n"
      ],
      "text/plain": [
       "         actual\n",
       "predicted no yes\n",
       "      no  0  4  \n",
       "      yes 1  0  "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# building the matrix\n",
    "error_cost <- matrix(c(0, 1, 4, 0), nrow = 2, dimnames = matrix_dimensions)\n",
    "error_cost"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "81066ecd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-01-23T13:14:13.316544Z",
     "iopub.status.busy": "2022-01-23T13:14:13.314163Z",
     "iopub.status.idle": "2022-01-23T13:14:13.406522Z",
     "shell.execute_reply": "2022-01-23T13:14:13.404313Z"
    },
    "papermill": {
     "duration": 0.253371,
     "end_time": "2022-01-23T13:14:13.406748",
     "exception": false,
     "start_time": "2022-01-23T13:14:13.153377",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "\n",
      " \n",
      "   Cell Contents\n",
      "|-------------------------|\n",
      "|                       N |\n",
      "|         N / Table Total |\n",
      "|-------------------------|\n",
      "\n",
      " \n",
      "Total Observations in Table:  300 \n",
      "\n",
      " \n",
      "               | predicted default \n",
      "actual default |        no |       yes | Row Total | \n",
      "---------------|-----------|-----------|-----------|\n",
      "            no |       125 |        79 |       204 | \n",
      "               |     0.417 |     0.263 |           | \n",
      "---------------|-----------|-----------|-----------|\n",
      "           yes |        27 |        69 |        96 | \n",
      "               |     0.090 |     0.230 |           | \n",
      "---------------|-----------|-----------|-----------|\n",
      "  Column Total |       152 |       148 |       300 | \n",
      "---------------|-----------|-----------|-----------|\n",
      "\n",
      " \n"
     ]
    }
   ],
   "source": [
    "# applying the cost matrix to the tree\n",
    "credit_cost <- C5.0(credit_train[-17], credit_train$default,\n",
    "                          costs = error_cost)\n",
    "credit_cost_pred <- predict(credit_cost, credit_test)\n",
    "\n",
    "CrossTable(credit_test$default, credit_cost_pred,\n",
    "           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,\n",
    "           dnn = c('actual default', 'predicted default'))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "0c5e51c1",
   "metadata": {
    "papermill": {
     "duration": 0.156754,
     "end_time": "2022-01-23T13:14:13.720455",
     "exception": false,
     "start_time": "2022-01-23T13:14:13.563701",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 72.295043,
   "end_time": "2022-01-23T13:14:13.992221",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-01-23T13:13:01.697178",
   "version": "2.3.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}

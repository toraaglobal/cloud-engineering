from email.mime import multipart
import streamlit as st 
import streamlit as st
import pandas as pd
import numpy as np
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.ensemble import RandomForestClassifier
from sklearn.preprocessing import LabelEncoder
from sklearn.model_selection import train_test_split
from sklearn.metrics import plot_confusion_matrix, plot_roc_curve, plot_precision_recall_curve
from sklearn.metrics import precision_score, recall_score 


st.set_option('deprecation.showPyplotGlobalUse', False)

@st.cache(persist=True)
def load_data(data):
    data = pd.read_csv(data)
    label = LabelEncoder()

    for col in data.columns:
        data[col] = label.fit_transform(data[col])
    return data 


@st.cache(persist=True)
def split(df):
    y = df.type 
    x = df.drop(columns=['type'])
    # split sample to test and train set / 30% for testing and 70% for training 
    x_train,x_test, y_train, y_test = train_test_split(x,y, test_size=0.3, random_state=0)
    return x_train, x_test,y_train, y_test 



def main():
    # header
    st.header('Machine Learning Binary Classification')
    col1, col2,col3 = st.columns(3)



    def plot_metrics(metric_list):
        if 'Confusion Metrix' in metric_list:
            st.subheader('Confusion Matrix')
            plot_confusion_matrix(model, x_test, y_test, display_labels=class_names)
            st.pyplot()

        if 'ROC Curve' in metric_list:
            st.subheader('ROC Curve')
            plot_roc_curve(model, x_test, y_test)
            st.pyplot()

        if 'Precision-Recall Curve' in metric_list:
            st.subheader('Precision-Recall Curve')
            plot_precision_recall_curve(model,x_test, y_test)
            st.pyplot()


    st.sidebar.title('Binary classififcation')
    data_file = st.sidebar.file_uploader('Upload data file',accept_multiple_files=False, key='data')

    if data_file:
        #st.write(pd.read_csv(data_file))
        df = load_data(data_file)

        x_train, x_test,y_train, y_test= split(df)
        class_names = ['edible', 'poisonous']

        if st.sidebar.checkbox('show raw data', False):
            st.subheader("Mushroom Data Set (Classification) ")
            st.write(df)

        st.sidebar.subheader('Choose Classifier')
        classifier = st.sidebar.selectbox('Classifier', (
            'Support Vector Machine (SVM)',
            'Logistic Rgression',
            'Random Forest'
        ))

        if classifier== 'Support Vector Machine (SVM)':
            st.sidebar.subheader('Model Hyperparameters')
            C = st.sidebar.number_input('C Regularization parameter', 0.01, 10.0, step=0.01, key='C')
            kennel = st.sidebar.radio('Kernel', ('rbf', 'linear'), key='kernel')
            gamma = st.sidebar.radio('Gamma', ('scale', 'auto'), key='gamma')

            metrics = st.sidebar.multiselect('Select your evaluation metrics to plot', (
                'Confusion Metrix',
                'ROC Curve' ,
                'Precision-Recall Curve'
            ))

            if st.sidebar.button('Run classification', key='classify'):
                st.subheader('Support Vector Machine (SVM) Results')
                model = SVC(C=C, kernel=kennel, gamma=gamma)
                model.fit(x_train, y_train)
                accuracy = model.score(x_test, y_test)
                y_pred = model.predict(x_test)

                with col1:
                    st.write('Accuracy: ',accuracy.round(2))
                with col2:
                    st.write('Precission: ', precision_score(y_test, y_pred,labels=class_names).round(2))
                with col3:
                    st.write('Recall: ', recall_score(y_test, y_pred,labels=class_names ).round(2))
                plot_metrics(metrics)






if __name__=='__main__':
    main()
   
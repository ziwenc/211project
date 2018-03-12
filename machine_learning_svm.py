from sklearn import svm
#from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score

import matplotlib.pyplot as plt
from sklearn.metrics import roc_curve, auc


import pandas as pd
#read in data from excel file
df = pd.read_excel(open('features.xlsx','rb'))
df['LESION SIZE']=df['LESION SIZE'].fillna(8)
#labels
labels = df['Label'].values
#features
features = df[['LESION SIZE', 'Mean', 'Median', 'std2', 'std', 'Contrast', 'Correlation', 'Energy', 'Homogeneity', 'SRE', 'LRE', 'GLN', 'RLN', 'RP', 'LGRE', 'HGRE', 'SGLGE', 'SRHGE', 'LRLGE', 'LRHGE', 'grdtmean', 'grdtvariance', 'grdtkurtosis', 'grdtskewness']].values

#X_train,X_test,Y_train,Y_test = train_test_split(features,labels,test_size=0.1)

# Create SVM classification object
clf = svm.SVC()
#train data
#clf.fit(X_train,Y_train)


#validation
scores=cross_val_score(clf,features,labels,cv=10)
print scores

print("Accuracy: %0.2f (+/- %0.2f)" % (scores.mean(), scores.std() * 2))



fpr = dict()
tpr = dict()
roc_auc = dict()
for i in range(2):
    fpr[i], tpr[i], _ = roc_curve(test, pred)
    roc_auc[i] = auc(fpr[i], tpr[i])

print roc_auc_score(test, pred)
plt.figure()
plt.plot(fpr[1], tpr[1])
plt.xlim([0.0, 1.0])
plt.ylim([0.0, 1.05])
plt.xlabel('False Positive Rate')
plt.ylabel('True Positive Rate')
plt.title('Receiver operating characteristic')
plt.show()
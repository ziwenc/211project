from sklearn.ensemble import GradientBoostingClassifier

#from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
import pandas as pd
#read in data from excel file
df = pd.read_excel(open('features.xlsx','rb'))
df['LESION SIZE']=df['LESION SIZE'].fillna(8)
#labels
labels = df['Label'].values
#features
features = df[['LESION SIZE', 'Mean', 'Median', 'std2', 'std', 'Contrast', 'Correlation', 'Energy', 'Homogeneity', 'SRE', 'LRE', 'GLN', 'RLN', 'RP', 'LGRE', 'HGRE', 'SGLGE', 'SRHGE', 'LRLGE', 'LRHGE', 'grdtmean', 'grdtvariance', 'grdtkurtosis', 'grdtskewness']].values

#X_train,X_test,Y_train,Y_test = train_test_split(features,labels,test_size=0.1)

# Create Boost classification object
clf = GradientBoostingClassifier(n_estimators=100, learning_rate=1.0,max_depth=1, random_state=0)
#train data
#clf.fit(X_train,Y_train)


#validation
scores=cross_val_score(clf,features,labels,cv=10)
print scores

print("Accuracy: %0.2f (+/- %0.2f)" % (scores.mean(), scores.std() * 2))




filename = 'population_data.csv';
data = readtable(filename);
table_Helsinki=data(strcmp(data.Area,"Helsinki"),:);
table_Espoo=data(strcmp(data.Area,"Espoo"),:);
table_Vantaa=data(strcmp(data.Area,"Vantaa"),:);

%convert tables to arrays
data_Helsinki=table2array(table_Helsinki(:,2:end));
data_Espoo=table2array(table_Espoo(:,2:end));
data_Vantaa=table2array(table_Vantaa(:,2:end));
X=[data_Helsinki;data_Espoo;data_Vantaa];

%get the targets
target_Hel=table2array(table_Helsinki(:,1));
target_Es=table2array(table_Espoo(:,1));
target_Va=table2array(table_Vantaa(:,1));
targets=[target_Hel;target_Es;target_Va];

dissimilarities = pdist(X); %dissimilarity matrix
%MDS scaling
[Y,stress] = mdscale(dissimilarities,2,'criterion','metricsstress');
distances=pdist(Y);

%Shepard plot
plot(dissimilarities,distances,'bo', ...
[0 max(dissimilarities)],[0 max(dissimilarities)],'r.-');
xlabel('Input distances'); ylabel('Output distances')

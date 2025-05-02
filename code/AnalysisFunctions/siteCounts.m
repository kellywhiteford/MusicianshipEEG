function siteCounts(dataMi3,uniID)

% uniID should be a string with the site university ID

subj_uni = dataMi3.subj_uni;

uni_IDs = extractAfter(subj_uni,'_'); % university ID for each subject

inds =  strcmp(uniID,uni_IDs); % indices for particular university

s = dataMi3.subj_uni(inds); 
G = dataMi3.Group(inds);
age = dataMi3.age(inds);


n_Mus = sum(strcmp(G,'Mus'))
n_Nmus= sum(strcmp(G,'NMus'))
n_Var = sum(strcmp(G,'Var'))
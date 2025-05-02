function site = siteCode(uniID)

site = zeros(length(uniID),1);

for ii = 1:length(uniID)
    if strcmp(uniID(ii),'bu')
        site(ii) = 1;
    elseif strcmp(uniID(ii),'cmu')
        site(ii) = 2;
    elseif strcmp(uniID(ii),'pu')
        site(ii) = 3;
    elseif strcmp(uniID(ii),'umn')
        site(ii) = 4;
    elseif strcmp(uniID(ii),'ur')
        site(ii) = 5;
    elseif strcmp(uniID(ii),'uwo')
        site(ii) = 6;
    end
end
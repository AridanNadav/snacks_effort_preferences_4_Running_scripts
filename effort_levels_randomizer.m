% Creating difficulty levels vector.
effort_levels = 10:20:90; % Precent from mvc
random_levels = randperm(length(effort_levels));
effort_req = zeros(1,length(effort_levels));
for i=1:length(effort_levels)
    % The 'help' each image gets (low difficulty iamges would move up
    % easyer)
    effort_req(random_levels(i)) = inv(effort_levels(random_levels(i))/100);
end
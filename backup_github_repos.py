from github import Github

import os
import pdb


path = '/mnt/d/Sync/GitHub'


def parse_path(path):
    '''
    Parses the input path to make sure that the path is OS independent.

    Args:
        path: (str) path to be parsed

    Returns:
        parsed_path: (str) path parsed using os.path.join
    '''

    parsed_path = '/'
    for dir in path.split('/'):
        parsed_path = os.path.join(parsed_path, dir)

    return parsed_path


def clone_repo(repo, repo_path):
    '''
    Clones a repo and updates if it has submodules

    Args:
        repo: (object) repo needs to be clones or updated
        repo_path: (str) path where the repo needs to be cloned

    Returns:
        None
    '''

    print('cloning at {}'.format(repo_path))

    os.system('git clone {}'.format(repo.ssh_url))
    os.chdir(repo_path)
    if os.path.exists(os.path.join(repo_path, '.gitmodules')):
        os.system('git submodule update --init')

    return


def update_repo(repo_path):
    '''
    Pulls from a remote repo and updates if it has submodules.

    Args:
        repo_path: (str) path for repo needs to be updated

    Returns:
        None
    '''

    print('updating {}'.format(repo_path))

    os.chdir(repo_path)
    os.system('git pull --all')
    if os.path.exists(os.path.join(repo_path, '.gitmodules')):
        os.system('git submodule update')

    return


def clone_or_update(repo, path):
    '''
    Clones the repo is it does not exist, if exists, update the repo

    Args:
        repo: (object) repo needs to be clones or updated
        path: (str) path where the repo needs to be cloned

    Returns:
        None
    '''

    os.chdir(path)
    repo_path = os.path.join(path, repo.name)


    if os.path.isdir(repo_path):
        update_repo(repo_path)
    else:
        clone_repo(repo, repo_path)

    os.chdir(path)

    return


def get_sub_dir(path, sub_dir_name):
    '''
    Create subdirectories if they do not exist, and returns the OS safe parsed
    sub directory path

    Args:
        path: (str) path of the parent directory
        sub_dir_name: (str) name of the subdirectory

    Returns:
        sub_dir: (str) OS safe subdirectory
    '''

    sub_dir = os.path.join(path, sub_dir_name)

    if not os.path.isdir(sub_dir):
        os.system('mkdir {}'.format(sub_dir_name))

    return sub_dir


def get_orgs(g):
    '''
    Get all the organizations of a user from GitHub object.

    Args:
        g: (object) GitHub object generated by pygithub
    Returns:
        orgs: (dict) dictionary containing organization data
    '''

    orgs = {'org_list':[]}
    for org in g.get_user().get_orgs():
        login = org.login
        orgs['org_list'].append(login)
        orgs['num_{}_repos'.format(login)] = 0
    return orgs


def print_sammary(num_personal_repos, num_contributed_repos, orgs):
    '''
    Prints the summary of the backup process

    Args:
        num_personal_repos: (int) number of personal repositories
        num_contributed_repos: (int) number of contributed repositories
        orgs: (dict) dictionary containing organization data
    Returns:
        None
    '''

    print('\n\nFinished GitHub backup!\n')
    print('\n\n======================================\n')
    print('\tSummary\n')
    print('======================================\n')
    print('Updated {} personal repos'.format(num_personal_repos))
    print('Updated {} contributed repos'.format(num_contributed_repos))

    for org in orgs_list:
        print('Updated {} {} repos'.format(orgs['num_{}_repos'.format(org)], org))

    print('\n======================================\n')

    return


# !!! DO NOT EVER USE HARD-CODED VALUES HERE !!!
# Instead, set and test environment variables, see README for info
GH_ACCSS_TKN = os.environ['GH_ACCSS_TKN']
g = Github(GH_ACCSS_TKN)

user = g.get_user().login
repos = g.get_user().get_repos()

path = parse_path(path)

os.chdir(path)
orgs = get_orgs(g)
orgs_list = orgs['org_list']

num_personal_repos = 0
num_contributed_repos = 0
for repo in repos:
    owner = repo.owner.login
    os.chdir(path)
    if owner == user:
        print('\nOwned repo: {}'.format(repo.name))
        sub_dir = get_sub_dir(path, 'personal')
        num_personal_repos += 1
        clone_or_update(repo, sub_dir)

    else:
        for mem in repo.get_contributors():
            if mem.login == user:
                if owner in orgs_list:
                    print('\n{} repo: {}'.format(owner, repo.name))
                    sub_dir = get_sub_dir(path, owner)
                    orgs['num_{}_repos'.format(owner)] += 1
                    clone_or_update(repo, sub_dir)
                else:
                    print('\nContributed repo: {}'.format(repo.name))
                    sub_dir = get_sub_dir(path, 'contributed')
                    num_contributed_repos += 1
                    clone_or_update(repo, sub_dir)

print_sammary(num_personal_repos, num_contributed_repos, orgs)

#!/usr/bin/env python2
# encoding: utf-8

import taskw
import argparse


def argparser():
    parser = argparse.ArgumentParser()
    parser.add_argument('project', type=str, metavar="project")
    parser.add_argument(
        '-f', '--from', dest='entry.after', type=str, metavar="YYYY-DD-MM",
        help="From date, inclusive")
    parser.add_argument(
        '-t', '--to', type=str, dest='entry.before', metavar="YYYY-DD-MM",
        help="To date, exclusive")
    return parser


def get_total(tasks):
    return sum([int(t['totalactivetime'].split('seconds')[0]) for t in tasks
                if t.get('totalactivetime')])


def parse_seconds(sec):
    m, s = divmod(sec, 60)
    h, m = divmod(m, 60)
    return h, m, s


def main(args):
    project = args.project
    print("Parsing project %s" % project)
    tw = taskw.TaskWarrior()
    filter_ = {'status': 'completed'}
    for k, v in args._get_kwargs():
        if v:
            filter_[k] = v
    tasks = tw.filter_tasks(filter_)
    total = get_total(tasks)
    h, m, s = parse_seconds(total)
    print("Total for project %s is %d:%d:%d" % (project, h, m, s))


if __name__ == '__main__':
    parser = argparser()
    args = parser.parse_args()
    main(args)

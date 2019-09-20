#-- encoding: UTF-8
#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2018 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See docs/COPYRIGHT.rdoc for more details.
#++
require 'spec_helper'

describe OpenProject::Database do
  before do
    described_class.instance_variable_set(:@version, nil)
  end

  after do
    described_class.instance_variable_set(:@version, nil)
  end

  it 'should return the correct identifier' do
    allow(OpenProject::Database).to receive(:adapter_name).and_return 'PostgresQL'

    expect(OpenProject::Database.name).to equal(:postgresql)
  end

  it 'should be able to use the helper methods' do
    allow(OpenProject::Database).to receive(:adapter_name).and_return 'PostgresQL'

    expect(OpenProject::Database.postgresql?).to equal(true)
  end

  it 'should return a version string for PostgreSQL' do
    allow(OpenProject::Database).to receive(:adapter_name).and_return 'PostgreSQL'
    raw_version = 'PostgreSQL 8.3.11 on x86_64-pc-linux-gnu, compiled by GCC gcc-4.3.real (Debian 4.3.2-1.1) 4.3.2'
    allow(ActiveRecord::Base.connection).to receive(:select_value).and_return raw_version

    expect(OpenProject::Database.version).to eq('8.3.11')
    expect(OpenProject::Database.version(true)).to eq(raw_version)
  end
end

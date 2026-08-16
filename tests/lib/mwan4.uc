// Mock mwan4 ucode module for pbr tests.
//
// platform.uc requires this when is_mwan4_installed() returns true.
// Tests gate that via fs mocks (access on /etc/init.d/mwan4 + stat
// on /etc/config/mwan4); without those, this mock is loaded into the
// require search path but never invoked.

function config() {
	return global.mocklib.read_json_file('mwan4/config.json') || {};
}

return {
	load: function() {},
	get_interfaces: function() {
		return config().interfaces || [];
	},
	get_iface_mark: function(iface) {
		return config().marks?.[iface] || null;
	},
	get_iface_chain: function(iface) {
		return config().interface_chains?.[iface] || null;
	},
	get_strategies: function() {
		return config().strategies || ['balanced', 'failover'];
	},
	get_strategy_chain: function(strategy) {
		return config().strategy_chains?.[strategy] || 'mwan4_strategy_' + strategy;
	},
};

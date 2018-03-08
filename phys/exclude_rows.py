from __future__ import (print_function, division, unicode_literals,
                        absolute_import)
from sympathy.api import fx_wrapper

import numpy as np

class ExcludeRows(fx_wrapper.FxWrapper):
    """Add function documentation here"""

    arg_types = ['(table, table)']

    def execute(self):

        index_tbl = self.arg[0]
        value_tbl = self.arg[1]
        out_tbl = self.res[0]

        indices = index_tbl.cols()[0].data - 1

        for col in value_tbl.cols():
            mask = np.ones(col.data.shape[0], dtype=bool)
            mask[indices] = False
            out_tbl.set_column_from_array(col.name, col.data[mask])

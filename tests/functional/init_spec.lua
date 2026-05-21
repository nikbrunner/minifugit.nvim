---@diagnostic disable: undefined-field
describe('flux', function()
    before_each(function()
        package.loaded.flux = nil
    end)

    it('sets defaults and marks setup as done', function()
        ---@type Flux
        local flux = require('flux').setup()

        assert.is_true(flux.did_setup)
        assert.are.equal(false, flux.config.options.preview.wrap)
        assert.are.equal(
            'stacked',
            flux.config.options.preview.diff_layout
        )
        assert.are.equal(0.4, flux.config.options.status.width)
    end)

    it('merges valid options without losing defaults', function()
        ---@type Flux
        local flux = require('flux').setup({
            preview = { show_metadata = false, diff_layout = 'split' },
            status = { min_width = 30 },
        })

        assert.are.equal(false, flux.config.options.preview.show_metadata)
        assert.are.equal('split', flux.config.options.preview.diff_layout)
        assert.are.equal(false, flux.config.options.preview.wrap)
        assert.are.equal(30, flux.config.options.status.min_width)
        assert.are.equal(0.4, flux.config.options.status.width)
    end)

    it('rejects invalid setup options', function()
        assert.has_error(function()
            require('flux').setup({ preview = { diff_layout = 'wide' } })
        end, "opts.preview.diff_layout must be 'stacked', 'split', or 'auto'")

        assert.has_error(function()
            require('flux').setup({ status = { width = 2 } })
        end, 'opts.status.width must be a number between 0 and 1')
    end)
end)

var joi = require('joi')
module.exports = {
  'status.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      statusId: joi.number().required()
    }),
    result: joi.object().keys({
      statusId: joi.number(),
      name: joi.string(),
      description: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'status.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      statusId: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        statusId: joi.number(),
        name: joi.string(),
        description: joi.string()
      }).allow(null)
    )
  },
  'target.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      targetId: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        targetId: joi.number(),
        name: joi.string(),
        description: joi.string()
      }).allow(null)
    )
  },
  'target.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      targetId: joi.number().required()
    }),
    result: joi.object().keys({
      targetId: joi.number(),
      name: joi.string(),
      description: joi.string()
    })
  },
  'operation.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      operationId: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        operationId: joi.number(),
        name: joi.string(),
        description: joi.string(),
        params: joi.array().items(joi.string())
      }).allow(null)
    )
  },
  'operation.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      operationId: joi.number().required()
    }),
    result: joi.object().keys({
      operationId: joi.number(),
      name: joi.string(),
      description: joi.string(),
      params: joi.array().items(joi.string())
    })
  },
  'channel.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      channelId: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        channelId: joi.number(),
        name: joi.string(),
        description: joi.string()
      }).allow(null)
    )
  },
  'channel.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      channelId: joi.number().required()
    }),
    result: joi.object().keys({
      channelId: joi.number(),
      name: joi.string(),
      description: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'template.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      channelId: joi.number().required(),
      operationId: joi.number().required(),
      targetId: joi.number().required()
    }),
    result: joi.object().keys({
      templateId: joi.number(),
      name: joi.string(),
      channelId: joi.number(),
      operationId: joi.number(),
      targetId: joi.number(),
      content: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'template.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      templateId: joi.number(),
      channelId: joi.number(),
      operationId: joi.number(),
      targetId: joi.number(),
      pageSize: joi.number(),
      pageNumber: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        templateId: joi.number(),
        name: joi.string(),
        channelId: joi.number(),
        operationId: joi.number(),
        targetId: joi.number(),
        content: joi.string()
      })
    ).allow(null)
  },
  'template.add': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      name: joi.string(),
      channelId: joi.number().required(),
      operationId: joi.number().required(),
      targetId: joi.number().required(),
      content: joi.string()
    }),
    result: joi.object().keys({
      templateId: joi.number(),
      name: joi.string(),
      channelId: joi.number(),
      operationId: joi.number(),
      targetId: joi.number(),
      content: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'template.edit': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      templateId: joi.number().required(),
      name: joi.string(),
      channelId: joi.number(),
      operationId: joi.number(),
      targetId: joi.number(),
      content: joi.string()
    }),
    result: joi.object().keys({
      templateId: joi.number(),
      name: joi.string(),
      channelId: joi.number(),
      operationId: joi.number(),
      targetId: joi.number(),
      content: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'add.execute': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      channelId: joi.number().required(),
      operationId: joi.number().required(),
      targetId: joi.number().required(),
      actorId: joi.string(),
      destinations: joi.array().items(joi.string()),
      params: joi.object()
    }),
    result: joi.object().keys({
      addedRecords: joi.number()
    })
  },
  'notification.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      actorId: joi.number().example('1000'),
      notificationId: joi.number(),
      templateId: joi.number(),
      statusId: joi.number(),
      destination: joi.string(),
      from: joi.date(),
      to: joi.date(),
      pageSize: joi.number(),
      pageNumber: joi.number(),
      recordsTotal: joi.number(),
      pagesTotal: joi.number()
    }),
    result: joi.object().keys({
      data: joi.array().items(joi.object({
        notificationId: joi.number(),
        templateId: joi.number(),
        statusId: joi.number(),
        statusName: joi.string(),
        destination: joi.string(),
        content: joi.string(),
        params: joi.object(),
        createdOn: joi.date(),
        updatedOn: joi.date()
      })),
      pagination: joi.object(),
      isSingleResult: joi.boolean()
    })
  },
  'notification.edit': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationId: joi.number(),
      statusId: joi.number(),
      destination: joi.string(),
      content: joi.string()
    }),
    result: joi.object().keys({
      notificationId: joi.number(),
      templateId: joi.number(),
      statusId: joi.number(),
      destination: joi.string(),
      content: joi.string(),
      params: joi.object(),
      createdOn: joi.date(),
      updatedOn: joi.date(),
      isSingleResult: joi.boolean()
    })
  }
}

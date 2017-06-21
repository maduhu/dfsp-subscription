var joi = require('joi')
module.exports = {
  'notificationStatus.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationStatusId: joi.number().required()
    }),
    result: joi.object().keys({
      notificationStatusId: joi.number(),
      name: joi.string(),
      description: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'notificationStatus.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationStatusId: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        notificationStatusId: joi.number(),
        name: joi.string(),
        description: joi.string()
      }).allow(null)
    )
  },
  'notificationTarget.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationTargetId: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        notificationTargetId: joi.number(),
        name: joi.string(),
        description: joi.string()
      }).allow(null)
    )
  },
  'notificationTarget.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationTargetId: joi.number().required()
    }),
    result: joi.object().keys({
      notificationTargetId: joi.number(),
      name: joi.string(),
      description: joi.string()
    })
  },
  'notificationOperation.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationOperationId: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        notificationOperationId: joi.number(),
        name: joi.string(),
        description: joi.string(),
        params: joi.array().items(joi.string())
      }).allow(null)
    )
  },
  'notificationOperation.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationOperationId: joi.number().required()
    }),
    result: joi.object().keys({
      notificationOperationId: joi.number(),
      name: joi.string(),
      description: joi.string(),
      params: joi.array().items(joi.string())
    })
  },
  'notificationChannel.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationChannelId: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        notificationChannelId: joi.number(),
        name: joi.string(),
        description: joi.string()
      }).allow(null)
    )
  },
  'notificationChannel.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationChannelId: joi.number().required()
    }),
    result: joi.object().keys({
      notificationChannelId: joi.number(),
      name: joi.string(),
      description: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'notificationTemplate.get': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationChannelId: joi.number().required(),
      notificationOperationId: joi.number().required(),
      notificationTargetId: joi.number().required()
    }),
    result: joi.object().keys({
      notificationTemplateId: joi.number(),
      name: joi.string(),
      notificationChannelId: joi.number(),
      notificationOperationId: joi.number(),
      notificationTargetId: joi.number(),
      content: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'notificationTemplate.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationTemplateId: joi.number(),
      notificationChannelId: joi.number(),
      notificationOperationId: joi.number(),
      notificationTargetId: joi.number(),
      pageSize: joi.number(),
      pageNumber: joi.number()
    }),
    result: joi.array().items(
      joi.object({
        notificationTemplateId: joi.number(),
        name: joi.string(),
        notificationChannelId: joi.number(),
        notificationOperationId: joi.number(),
        notificationTargetId: joi.number(),
        content: joi.string()
      })
    ).allow(null)
  },
  'notificationTemplate.add': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      name: joi.string(),
      notificationChannelId: joi.number().required(),
      notificationOperationId: joi.number().required(),
      notificationTargetId: joi.number().required(),
      content: joi.string()
    }),
    result: joi.object().keys({
      notificationTemplateId: joi.number(),
      name: joi.string(),
      notificationChannelId: joi.number(),
      notificationOperationId: joi.number(),
      notificationTargetId: joi.number(),
      content: joi.string(),
      isSingleResult: joi.boolean()
    })
  },
  'add.execute': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationChannelId: joi.number().required(),
      notificationOperationId: joi.number().required(),
      notificationTargetId: joi.number().required(),
      destination: joi.string(),
      params: joi.object()
    }),
    result: joi.object().keys({
      notificationId: joi.number(),
      notificationTemplateId: joi.number(),
      notificationStatusId: joi.number(),
      destination: joi.string(),
      content: joi.string(),
      params: joi.object(),
      createdOn: joi.date(),
      updatedOn: joi.date(),
      isSingleResult: joi.boolean()
    })
  },
  'notification.fetch': {
    description: '',
    notes: '',
    auth: false,
    params: joi.object().keys({
      notificationId: joi.number(),
      notificationTemplateId: joi.number(),
      notificationStatusId: joi.number(),
      destination: joi.string(),
      from: joi.date(),
      to: joi.date(),
      pageSize: joi.number(),
      pageNumber: joi.number()
    }),
    result: joi.object().keys({
      data: joi.object(),
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
      notificationStatusId: joi.number(),
      destination: joi.string(),
      content: joi.string()
    }),
    result: joi.object().keys({
      notificationId: joi.number(),
      notificationTemplateId: joi.number(),
      notificationStatusId: joi.number(),
      destination: joi.string(),
      content: joi.string(),
      params: joi.object(),
      createdOn: joi.date(),
      updatedOn: joi.date(),
      isSingleResult: joi.boolean()
    })
  }
}

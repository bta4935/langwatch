import { type Node } from "@xyflow/react";
import type { Component, Field } from "~/optimization_studio/types/dsl";

export const calculateNextPosition = (position: Node<Component>["position"]) =>
  position
    ? {
        x: position.x + 300,
        y: position.y - 50,
      }
    : { x: 0, y: 0 };

/**
 * Generic parameter update function
 * Will add the parameter if it doesn't exist and update the value if it does
 */
export function updateNodeParameter(
  node: Node<Component>,
  parameter: Partial<Omit<Field, "value">> & {
    identifier: string;
    type: Field["type"];
    value?: any;
  }
): Node<Component> {
  const parameters = node.data.parameters ?? [];
  const paramIndex = parameters.findIndex(
    (p) => p.identifier === parameter.identifier
  );

  const updatedParameters =
    paramIndex === -1
      ? [...parameters, parameter]
      : parameters.map((param, index) =>
          index === paramIndex ? { ...param, ...parameter } : param
        );

  return {
    ...node,
    data: {
      ...node.data,
      parameters: updatedParameters,
    },
  };
}
